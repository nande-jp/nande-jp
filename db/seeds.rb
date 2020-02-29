require 'faker'
Faker::Config.locale = :ja

require 'csv'
require 'net/http'
require 'set'
require 'mechanize'
require 'rubygems'

AGENT = Mechanize.new
BASE_URL = 'https://yomikatawa.com/kanji/'

category_mappings = {
  '日常系' => :daily_occurences,
  '科学系' => :nature,
  '化学系' => :nature,
  '哲学系' => :philosophy,
  '自然系' => :nature,
}

gender_mappings = {
  "男の子" => :male,
  "女の子" => :female
}

def generate_nickname(name)
  # Fetch page
  url = "https://www.namaenomori.com/nickname/make01n?nmY=#{to_hiragana(name)}&myY=&sx=n&nmN=&myN=&im=0"
  page = AGENT.get(url)

  nicknames = page.search('meta[name="description"]')[0][:content].split('、')

  nicknames.each do |name|
    return name unless User.find_by_username(name)
  end
end

def to_hiragana(kanji)
  begin
    AGENT.get(BASE_URL + kanji).search('#content p').first.inner_text
  rescue
    return kanji
  end
end

CSV.foreach(Rails.root.join('lib/tasks/new_content_0226.csv'), headers: true) do |row|
  name = generate_nickname((Faker::Name.unique.name).split(' ')[0])

  user = User.order('RANDOM()').first

  child_name = generate_nickname((Faker::Name.unique.name).split(' ')[1])
  child = user.children.create!(age: row['age'].to_i, gender: gender_mappings[row['gender']], nickname: child_name)

  next unless Question.find_by_content(row['content']).nil?

  question = user.questions.create!(category: category_mappings[row['category']], content: row['content'], child: child)

  answer_user = User.where.not(id: user.id).order('RANDOM()').first
  answer = question.answers.create!(content: row['answer_content'], points: row['points'], user_id: answer_user.id)
end

AdminUser.create!(email: 'admin@nande-kids.jp', password: 'shibayama2013', password_confirmation: 'shibayama2013') if Rails.env.development? && AdminUser.count == 0
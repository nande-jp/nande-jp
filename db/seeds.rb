require 'faker'
Faker::Config.locale = :ja

require 'csv'

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

CSV.foreach(Rails.root.join('lib/tasks/content.csv'), headers: true) do |row|
  name = Faker::Name.unique.name

  user = User.create!(email: Faker::Internet.email, username: name, password: 'password')
  user.children.create!(age: row['age'].to_i, gender: gender_mappings[row['gender']])

  question = user.questions.create!(category: category_mappings[row['category']], content: row['content'])

  answer_user = User.order('RANDOM()').first
  answer = question.answers.create!(content: row['answer_content'], points: row['points'], user_id: answer_user.id)
end
class Child < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :questions

  validates_presence_of :age, :gender, :nickname

  enum gender: [:male, :female, :other]

  def self.gender_map
    genders.map do |gender, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.genders.#{gender}"), gender]
    end
  end

  def gender_noun
    return '息子' if male?

    return '娘' if female?

    return 'こども'
  end

  def humanize
    return "#{age}歳#{gender_noun}"
  end
end

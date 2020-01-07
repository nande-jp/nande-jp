class Child < ApplicationRecord
  belongs_to :user, counter_cache: true

  validates_presence_of :age, :gender

  enum gender: [:male, :female]

  def self.gender_map
    genders.map do |gender, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.genders.#{gender}"), gender]
    end
  end

  def gender_noun
    return male? ? '息子' : '娘'
  end

  def humanize
    return "#{age}歳#{gender_noun}"
  end
end

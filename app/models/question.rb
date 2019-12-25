class Question < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :answers

  enum category: [:nature, :science, :philosophy, :daily_occurences]

  validates_presence_of :content, :category

  def category_name
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.categories.#{category}")
  end

  def self.category_map
    categories.map do |category, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.categories.#{category}"), category]
    end
  end
end

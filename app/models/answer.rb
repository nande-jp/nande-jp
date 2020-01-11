class Answer < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :question, counter_cache: true

  has_many :bookmarks
  has_many :shares

  enum category: [:for_parents, :for_children]

  validates_presence_of :content

  def bookmarked_by?(user)
    return false unless user
    !user.bookmarks.find_by(answer_id: id).nil?
  end

  def shared_by?(user)
    return false unless user
    !user.shares.find_by(answer_id: id).nil?
  end

  def category_name
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.categories.#{category}")
  end

  def self.category_map
    categories.map do |category, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.categories.#{category}"), category]
    end
  end
end

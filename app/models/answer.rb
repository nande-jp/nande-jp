class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question, counter_cache: true

  has_many :bookmarks

  enum category: [:nature, :science, :philosophy]

  validates_presence_of :content, :category

  def bookmarked_by?(user)
    !user.bookmarks.find_by(answer_id: id).nil?
  end
end

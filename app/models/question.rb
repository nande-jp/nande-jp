class Question < ApplicationRecord
  belongs_to :user
  has_many :answers

  enum category: [:nature, :science, :philosophy]

  validates_presence_of :content, :category
end

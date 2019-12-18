class Question < ApplicationRecord
  belongs_to :user

  enum category: [:nature, :science, :philosophy]

  validates_presence_of :content, :category
end

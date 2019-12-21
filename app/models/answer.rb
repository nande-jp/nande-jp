class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question, counter_cache: true

  enum category: [:nature, :science, :philosophy]

  validates_presence_of :content, :category
end

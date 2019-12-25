class Question < ApplicationRecord
  belongs_to :user
  has_many :answers

  enum category: {nature: 1, science: 2, philosophy: 3, daily_occurances: 4}

  validates_presence_of :content, :category
end

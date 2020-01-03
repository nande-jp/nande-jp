class Child < ApplicationRecord
  belongs_to :user

  validates_presence_of :age, :gender

  enum gender: [:male, :female, :other]
end

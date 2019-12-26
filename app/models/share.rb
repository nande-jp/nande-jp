class Share < ApplicationRecord
  belongs_to :user
  belongs_to :answer, counter_cache: true

  validates_uniqueness_of :answer, scope: :user
end

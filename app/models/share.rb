class Share < ApplicationRecord
  belongs_to :user
  belongs_to :answer, counter_cache: true
end

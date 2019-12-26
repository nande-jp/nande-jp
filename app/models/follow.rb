class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: 'follower_id', class_name: 'User'
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'

  after_save :increment_counter!
  after_destroy :decrement_counter!

  validates_uniqueness_of :follower, scope: :following

  private

  def increment_counter!
    follower.increment!(:followers_count)
    following.increment!(:followings_count)
  end

  def decrement_counter!
    follower.decrement!(:followers_count)
    following.decrement!(:followings_count)
  end
end

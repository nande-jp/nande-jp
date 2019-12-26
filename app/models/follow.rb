class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: 'follower_id', class_name: 'User'
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'

  after_commit :increment_counter!

  private

  def increment_counter!
    follower.increment!(:followers_count)
    following.increment!(:followings_count)
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :questions
  has_many :answers
  has_many :bookmarks
  has_many :shares

  has_many :follows

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followings, through: :following_relationships, source: :following

  has_many :children
  accepts_nested_attributes_for :children, allow_destroy: true, reject_if: ->(child){ child['age'].blank? && child['gender'].blank? }


  def is_following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  def children_profile
    return "" if children_count == 0
    "#{children.map{|child| child.humanize}.join('、')}の親"
  end
end

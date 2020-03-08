class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[twitter]

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :shares, dependent: :destroy

  has_many :follows

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower, dependent: :destroy

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followings, through: :following_relationships, source: :following

  has_many :children, dependent: :destroy
  accepts_nested_attributes_for :children, allow_destroy: true, reject_if: ->(child){ child['age'].blank? && child['gender'].blank? }

  enum gender: [:male, :female, :other]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.nickname # assuming the user model has a username
      user.avatar = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.gender_map
    genders.map do |gender, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.genders.#{gender}"), gender]
    end
  end

  def is_following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  def children_profile
    return "" if children_count == 0
    "#{children.map{|child| child.humanize}.join('、')}の#{parent_name}"
  end

  def parent_name
    return 'パパ' if male?
    return 'ママ' if female?
    '親'
  end
end

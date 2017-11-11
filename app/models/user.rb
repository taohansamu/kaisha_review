class User < ApplicationRecord
  has_many :companies, dependent: :destroy
  has_many :reviews,    dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  default_scope -> { order(created_at: :desc) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  mount_uploader :avatar, AvatarUploader
  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar
  # Follows a user.
  def follow(company)
    following << company
  end

  # Unfollows a user.
  def unfollow(company)
    following.delete(company)
  end

  # Returns true if the current user is following the other user.
  def following?(company)
    following.include?(company)
  end

  def self.new_with_session params, session
    super.tap do |user|
      if data = session["devise.facebook_data"] &&
        session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
      if data = session["devise.google_oauth2_data"] &&
          session["devise.google_oauth2_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  # TODO: skip confirm
  def confirmation_required?
    false
  end
  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
      user.skip_confirmation!
    end
  end
end

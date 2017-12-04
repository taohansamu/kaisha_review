class Company < ApplicationRecord
  belongs_to :user
  has_many :reviews,    dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :reviewed_users, through: :reviews, source: :user
  validates :logo, presence: true
  self.per_page = 6
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  mount_uploader :logo, PictureUploader
  mount_uploader :cover, PictureUploader
end

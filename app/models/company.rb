class Company < ApplicationRecord
  belongs_to :user
  validates :logo, presence: true
  self.per_page = 6
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  mount_uploader :logo, PictureUploader
  mount_uploader :cover, PictureUploader
end

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :company
  validates :comment, presence: true,
            length: { minimum: 5 }
  validates :care_rate, presence: true
  validates :salary_rate, presence: true
  validates :workspace_rate, presence: true
end

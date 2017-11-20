class Review < ApplicationRecord
  belongs_to :user
  belongs_to :company
  validates :comment, presence: true,
            length: { minimum: 5 }
  validates :care_rate, presence: true
  validates :salary_rate, presence: true
  validates :workspace_rate, presence: true
  validates :training_rate, presence: true
  validates :culture_rate, presence: true
  validates :ot_rate, presence: true
  validates :summary_rate, presence: true
  validates :title, presence: true
  validates :user_id, uniqueness: { scope: :company_id,
    message: "Each user can only be reviewed once" }
end

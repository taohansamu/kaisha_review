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

  acts_as_notifiable :users,
                     targets: ->(review,key) {
                       (review.company.followers - [review.user]).uniq
                       # ([review.company.user] + review.company.reviewed_users.to_a - [review.user]).uniq
                     },
                     notifiable_path: :recipe_notificable_path

  def recipe_notificable_path
    company_path id: company.id
  end
end

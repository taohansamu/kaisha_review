class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:create, :index, :destroy]

  # return reviews not by current user
  def index 
    @reviews = @company.reviews.where('user_id != ?', current_user.id).all.paginate(:page => params[:page])
    render json: @reviews
  end
  def get_current_review
    @review = Review.find_by({user_id: current_user.id, company_id: params[:company_id]})
    render json: @review
  end
  def create
    @review = @company.reviews.create(review_params)
    @review.user_id = current_user.id
    @review.user = current_user
    if @review.save
      # ActivityNotification::Notification.notify :users, @review, key: "review.create", notifier: @review.user, group: @review.company
      ActivityNotification::Notification.notify :users, @review, key: "review.create", notifier: @review.user, group: @review.company
      notification_targets(@review, "review.create" ).each do |target_user|
        ReviewBroadcastJob.perform_later target_user, @review
      end
      render json: @review
    else
      render json: @review.errors, status: :unprocessable_entity 
    end
  end
  def update
    @review = Review.find_by({user_id: current_user.id}, company_id: params[:company_id])
    if @review.update(review_params)
      render json: @review, status: :ok
    else
      render json: @review.error, status: :unprocessable_entity
    end
  end
  def destroy
    @company.reviews.find(params[:id]).destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  private

  private
  def notification_targets review, key
    (review.company.followers - [review.user]).uniq
  end
  def set_company
    @company = Company.find(params[:company_id])
  end

  def review_params
    params[:review].permit(:comment, :workspace_rate, :salary_rate, :care_rate, :training_rate, :culture_rate, :ot_rate, :summary_rate, :company_id, :title, :page)
  end
end

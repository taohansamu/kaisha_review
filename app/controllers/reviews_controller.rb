class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:create, :index]

  def index
    @reviews = @company.reviews.paginate(:page => params[:page])
    render json: @reviews
  end
  def get_current_review
    @review = Review.find_by({user_id: current_user.id}, company_id: params[:company_id])
    render json: @review
  end
  def create
    @review = @company.reviews.create(review_params)
    @review.user_id = current_user.id
    @review.user = current_user
    if @review.save
      render json: @review
    else
      render json: @review.errors
    end
  end
  def update
    @review = Review.find_by({user_id: current_user.id}, company_id: params[:company_id])
    if @review.update(review_params)
      render json: @review
    else
      render json: @review.error
    end
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def review_params
    params[:review].permit(:comment, :workspace_rate,:salary_rate, :care_rate, :summary_rate, :company_id, :page)
  end
end

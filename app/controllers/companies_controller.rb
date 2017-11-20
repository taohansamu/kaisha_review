class CompaniesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy, :update, :edit, :show]
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :calculate, only: [:show]
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.paginate(:page => params[:page])
    render json: @companies
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    if current_user.following?(@company)
      @relationship = current_user.active_relationships.find_by({followed_id: params[:id]})
    end
    @review = Review.find_by({user_id: current_user.id, company_id: params[:id]})
    # @review = Review.where('user_id != ? AND company_id = ?', current_user.id, params[:id]).take;
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = current_user.companies.build(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :logo, :cover, :employees, :website, :address, :estabish, :investment, :overview)
    end
    def calculate
      company = Company.find(params[:id])
      @avg = company.reviews.average(:summary_rate);
      @review_total = company.reviews.count
      @five_star_total = company.reviews.where(:summary_rate => 5).count
      @four_star_total  = company.reviews.where(:summary_rate => 4).count
      @three_star_total = company.reviews.where(:summary_rate => 3).count
      @two_star_total = company.reviews.where(:summary_rate => 2).count
      @one_star_total = company.reviews.where(:summary_rate => 1).count

      @care_rate_total=company.reviews.sum(:care_rate)
      @salary_rate_total=company.reviews.sum(:salary_rate)
      @workspace_rate_total=company.reviews.sum(:workspace_rate)
      @training_rate_total = company.reviews.sum(:training_rate)
      @culture_rate_total = company.reviews.sum(:culture_rate)
      @ot_rate_total = company.reviews.sum(:ot_rate)
    end
end

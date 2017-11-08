class RelationshipsController < ApplicationController
    before_action :authenticate_user!
    def create
        company = Company.find(params[:followed_id])
        current_user.follow(company)
        render json: current_user.active_relationships.find_by({followed_id: params[:followed_id]}), status: :ok
    end

    def destroy
        user = Relationship.find(params[:id]).followed
        current_user.unfollow(user)
        render json: {}, status: :ok
    end
    def destroy_by_company
        current_user.unfollow(params[:company_id])
        render json: {}, status: :ok
    end
end

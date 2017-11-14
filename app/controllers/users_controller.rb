class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update_profile ]

  def update_profile
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to edit_user_registration_path(@user)
    else
      print @user.errors
      render 'devise/registrations/edit'
    end
  end

  def following
    @user  = User.find(params[:id])
    @companies = @user.following
  end

  private

  def user_params
    params.require(:user).permit(:username, :avatar, :gender,:occupation,:date_of_birth,:number_phone)
  end
end

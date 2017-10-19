class UsersController < ApplicationController
  def update_profile
    @user = current_user
    if current_user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to edit_user_registration_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :avatar, :gender,:occupation,:date_of_birth,:number_phone)
  end
end

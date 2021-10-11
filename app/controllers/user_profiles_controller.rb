class UserProfilesController < ApplicationController
  def new
    @user_profile = UserProfile.new
  end

  def create
    @user_profile = UserProfile.new(params.require(:user_profile).permit(:name, :social_name, :birth_date, :major, :bio, :experience, :picture))
    @user_profile.user = current_user
    if @user_profile.save! then
      redirect_to root_path
    else
      render :new
    end
  end
end

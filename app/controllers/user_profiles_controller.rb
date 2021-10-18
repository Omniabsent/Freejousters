class UserProfilesController < ApplicationController
  def new
    @user_profile = UserProfile.new
  end

  def create
    @user_profile = UserProfile.new(params.require(:user_profile).permit(:name, :social_name, :birth_date, :major, :bio, :experience, :picture))
    @user_profile.user = current_user
    if @user_profile.save then
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user_profile = UserProfile.find(params[:id])
  end

  def update
    @user_profile = UserProfile.find(params[:id])
    @user_profile.update(params.require(:user_profile).permit(:name, :social_name, :birth_date, :major, :bio, :experience, :picture))
    redirect_to user_profile_path
  end

  def show
    id = params[:id]
    @user_profile = UserProfile.find(id)
  end

end

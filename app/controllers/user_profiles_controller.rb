class UserProfilesController < ApplicationController
  def new
  end

  def create
    @profile = UserProfile.new(params.require(:user_profile).permit(:name, :social_name, :birth_date, :major, :bio, :experience, :picture))
    @profile.user_id = current_user
    if @profile.save then
      redirect_to root_path
    else
      render :new
    end
  end
end

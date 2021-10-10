class UserProfileController < ApplicationController
  def new
    @profile = UserProfile.new
  end

  def profile
    @profile = UserProfile.new(params.permit(:name, :social_name, :birth_date, :bio, :major, :experience, :picture))
    @profile.user_id = current_user
    if @profile.save then
      redirect_to root_path
    else
      render :profile
    end
  end
end

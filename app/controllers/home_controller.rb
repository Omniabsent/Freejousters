class HomeController < ApplicationController
  def index
  end

  def about
  end

  def hirer
    @user = current_user
    @user.role = 'hirer'
    if @user.save then
        redirect_to root_path
    end
  end

  def hireable
    @user = current_user
    @user.role = 'hireable'
    if @user.save then
        redirect_to root_path
    end
  end

end

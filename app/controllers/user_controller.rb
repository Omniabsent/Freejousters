class UserController < ApplicationController
  before_action :authenticate_user!

  def hirer
    @user = current_user
    @user.role = 'hirer'
    if @user.save then
      redirect_to root_path
      flash[:notice] = 'Usuário configurado como contratante'
    end
  end

  def hireable
    @user = current_user
    @user.role = 'hireable'
    if @user.save then
      redirect_to root_path
      flash[:notice] = 'Usuário configurado como profissional'
    end
  end

  #def show
  #  @user = current_user
  #end
end

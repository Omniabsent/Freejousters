class FavouritesController < ApplicationController

  def new
    @favourite = Favourite.new
  end

  def create
    @favourite = Favourite.new(params.require(:favourite).permit(:id))
    @favourite.favourite_user = params[:id]
    @favourite.user = current_user
    @favourite.save!

    redirect_to request.referer, notice: 'Você favoritou esse usuário'
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy

    redirect_to request.referer, notice: 'Você desfavoritou esse usuário'
  end

  def my_favourites
    @favourites = current_user.favourites
  end

end

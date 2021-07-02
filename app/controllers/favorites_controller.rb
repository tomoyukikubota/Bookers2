class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(user_id: user.id)
    favorite.save
    redirect_to user_favorites_path

  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(user_id: user.id)
    favorite.destroy
    redirect_to user_favorites_path
  end
end

class UsersController < ApplicationController

  def index
    @users = User.all
    @user = User.new
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @book_new = Book.new
    @books = Book.all
    @book = @user.books.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
end

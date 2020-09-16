class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @users = User.all
    @newbook = Book.new
  end

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @newbook = Book.new
    @books = @user.books.all
  end

private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
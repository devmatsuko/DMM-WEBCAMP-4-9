class UsersController < ApplicationController
  def index
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
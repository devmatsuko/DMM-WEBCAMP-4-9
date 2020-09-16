class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit, :update]}

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

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def ensure_current_user
    @current_user = current_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to  user_path(@current_user.id)
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
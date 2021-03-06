class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit, :update, :destroy]}

  def index
    @user = current_user
    @newbook = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @newbook = Book.new
      @books = Book.all
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @user = @book.user
      @newbook = Book.new
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def ensure_current_user
    @book = Book.find(params[:id])
    @current_user = current_user
    if @current_user.id != @book.user_id
      flash[:notice]="権限がありません"
      redirect_to  books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end

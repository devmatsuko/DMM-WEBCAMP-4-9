class BooksController < ApplicationController
  before_action :authenticate_user!

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
    @user = User.find(params[:id])
    @newbook = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @newbook = Book.new
      render :index
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end

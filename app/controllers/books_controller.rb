class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @newbook = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.find(params[:id])
    @newbook = Book.new
  end

  def edit
    @user = User.find(params[:id])
    @newbook = Book.new
    @books = @user.books.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      render books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end

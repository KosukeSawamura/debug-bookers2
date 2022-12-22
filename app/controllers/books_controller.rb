class BooksController < ApplicationController
before_action :login_user_matching, only: [:edit, :update]


  def new
    @book=Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @newbook=Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @book=Book.new
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def login_user_matching
    @book= Book.find(params[:id])
    user_id=@book.user_id
    login_user_id = current_user.id
    if(user_id != login_user_id)
     redirect_to books_path
    end
  end

end

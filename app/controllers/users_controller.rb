class UsersController < ApplicationController
  before_action:login_user_matching, only:[:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def index
    @users = User.all
    @book = Book.new
    @user = User.find(params[:id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
    @user=User.find(params[:id])

  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
   user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def login_user_matching
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)

     redirect_to user_path(login_user_id)
    end
  end
end

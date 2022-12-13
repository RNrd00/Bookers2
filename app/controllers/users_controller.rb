class UsersController < ApplicationController
    
    before_action :correct_user, only: [:edit, :update]
    
  def show
    @book = Book.new
    @users = User.find(params[:id])
    @books = @users.books  
  end

  def index
    @book = Book.new
    @users = User.all
    @user2 = current_user
  end
  
  def create
   @user = User.new(user_params)
   @user.user_id = current_user.id
    if @user.save
     flash[:success] = "You have created book successfully."
     redirect_to books_path
    end
  end
  
  def edit
   @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:success] = "You have updated user successfully."
     redirect_to user_path(@user.id)
    else
     render :edit
    end
  end
  
  def user_params
    params.require(:user).permit(:title, :body, :profile_image, :introduction, :name)
  end
  
  def correct_user
    @user = User.find(params[:id])
    @book = @user
    redirect_back(fallback_location: user_path(current_user)) unless @book == current_user
  end
  
end

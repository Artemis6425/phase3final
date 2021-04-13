class UsersController < ApplicationController

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to gamelist_url
    else
      redirect_to signup_url
    end 
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user == nil
      redirect_to gamelist_url
    end
  end

  def index
    @user = User.all
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :password)
  end

end
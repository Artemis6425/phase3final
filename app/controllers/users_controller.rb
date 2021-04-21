class UsersController < ApplicationController

  def new 
    @user = User.new
  end

  def create
    tempuser = User.find_by(name: user_params[:name])
    if tempuser == nil
      if user_params[:password] != user_params[:password_confirmation]
        flash[:notice] = "Passwords did not match, please try again!"
        redirect_to signup_url
        return
      end
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to gamelist_url
      else
        flash[:notice] = "Database error, please try again later!"
        redirect_to signup_url
      end 
    else
      flash[:notice] = "Username " + user_params[:name] + " already taken, please try again!"
      redirect_to signup_url
      return
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
    params.require(:user).permit(:name, :password, :password_confirmation) #I forgot password_confirmation
  end

end
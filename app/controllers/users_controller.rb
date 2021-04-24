class UsersController < ApplicationController #most routes edited

  def new 
    @user = User.new
  end

  def create
    tempuser = User.find_by(name: user_params[:name])
    @user = User.create(user_params)
    if tempuser == nil
      if user_params[:password] != user_params[:password_confirmation]
        flash[:notice] = "Passwords did not match, please try again!"
        render :new
        return
      end
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to games_path
      else
        flash[:notice] = "Database error, please try again later!"
        render :new
      end 
    else
      flash[:notice] = "Username " + user_params[:name] + " already taken, please try again!"
      render :new
      return
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user == nil
      redirect_to games_path
    end
  end

  def login
    @user = User.new
  end

  def postlogin
    @user = User.find_by(name: params[:name])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to games_path
    else
      if @user == nil
        flash[:notice] = "ERROR: Username not found!"
        render :login
      else

        flash[:notice] = "ERROR: Incorrect password!"
        render :login
      end
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
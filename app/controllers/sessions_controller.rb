class SessionsController < ApplicationController #all routes edited

  def destroy
    session.delete :user_id
    redirect_to games_path
  end

  def create
    @user = User.find_by(name: params[:name])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to games_path
    else
      flash[:notice] = "ERROR: Couldn't log in, please try again!"
      redirect_to login_path
    end
  end

  def oauthcreate
    @user = User.find_by(uid: auth['uid'])
    if @user == nil  #if it didn't find a user, it will create a new one
      @user = User.new(name: auth['extra']['id_info']['name'], uid: auth['uid'], password: SecureRandom.hex(12))
      if @user.save
        session[:user_id] = @user.id
        redirect_to games_path
      else
        yo dude idk #if this fails i legit have no idea how to solve it
      end
    else  #if it does find a user, it assumes all is correct 
      session[:user_id] = @user.id
      redirect_to games_path
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end



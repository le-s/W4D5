class SessionsController < ApplicationController

  def create #logging in
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user && !logged_in
      login(user)
      redirect_to user_url(user)
    end
  end

  def new #show the login page
    render :new
  end

  def destroy #logging out
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to new_session_url
    end
  end

end

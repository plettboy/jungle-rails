class SessionsController < ApplicationController

  def new
  end

  def create
   # user = User.find_by_email(params[:email])
   # if user && user.authenticate(params[:password])
      if user = User.authenticate_with_credentials(params[:email], params[:password])
      #if user and user password are true, store the user in sessions.
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
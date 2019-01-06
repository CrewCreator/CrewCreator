class SessionsController < ApplicationController
  def new
  end

  def create
    user = Admin.find_by_email(params[:email])
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to :controller => 'admins', :action => 'index'
      else
        flash.now[:alert] = 'Email or password is invalid'
        render 'new'
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :controller => 'admins', :action => 'index'
  end
end
class SessionsController < ApplicationController
  def new
  end

  def create
    if user = Admin.find_by_email(params[:email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        session[:is_admin] = true
        redirect_to controller: 'home', action: 'index'
      else
        flash[:notice] = "Failed to Log In! Password is invalid for #{params[:email]}"
        redirect_to '/login'
      end
    elsif user = Student.find_by_email(params[:email])
        if user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:is_admin] = false
          redirect_to controller: 'home', action: 'index'
        else
          flash[:notice] = "Failed to Log In! Password is invalid for #{params[:email]}"
          redirect_to '/login'
        end
    end
  end

  def destroy
    session[:user_id] = nil
    session[:is_admin] = nil
    redirect_to '/home'
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    #Determine if admin or student or moderator
    user = Admin.find_by_email(params[:email])
    
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to controller: 'home', action: 'index'
      else
        flash[:notice] = "Failed to Log In! Password is invalid for #{params[:email]}"
        redirect_to '/login'
      end
    else
      user = Student.find_by_email(params[:email])
      if user
        if user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to controller: 'home', action: 'index'
        else
          flash[:notice] = "Failed to Log In! Password is invalid for #{params[:email]}"
          redirect_to '/login'
        end
      else
        flash[:notice] = "Failed to Log In! #{params[:email]} is invalid"
        redirect_to '/login'
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/home'
  end
end

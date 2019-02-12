class SessionsController < ApplicationController
  def new
  end

  def create
    if user = Admin.find_by_email(params[:email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        session[:user] = "admin"
        redirect_to controller: 'home', action: 'index'
      else
        flash[:notice] = "Failed to Log In! Password is invalid"
        redirect_to '/login'
      end
    elsif user = Student.find_by_email(params[:email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        session[:user] = "student"
        redirect_to controller: 'home', action: 'index'
      else
        flash[:notice] = "Failed to Log In! Password is invalid"
        redirect_to '/login'
      end
    elsif user = Instructor.find_by_email(params[:email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        session[:user] = "instructor"
        redirect_to controller: 'home', action: 'index'
      else
        flash[:notice] = "Failed to Log In! Password is invalid"
        redirect_to '/login'
      end
    else
      flash[:notice] = "Failed to Log In! Account not found"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user] = nil
    redirect_to '/home'
  end
end

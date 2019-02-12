class StudentsController < ApplicationController
  before_action :is_admin, only: [:index]
  
  def index
    @students = Student.all
  end
  
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(student_params_create)
    if @student.save
      flash[:notice] = "#{@student.email} -- #{@student.name} was successfully created."
      if !current_user
        session[:user_id] = @student.id
        session[:user] = "student"
      end
      redirect_to home_path
    else
      flash[:notice] = "Email was taken or password did not meet specifications!"
      redirect_to '/createaccount'
    end
  end
  
  def edit
    id = params[:id]
    if (id.to_i != session[:user_id].to_i && session[:user] != "admin") || current_user == nil
      flash[:warning] = "You do not have admin privileges. Please log-in as an admin to continue."
      redirect_to new_session_path
    end
    @student = Student.find(id)
  end
  
  def update
    id = params[:id]
    if (id.to_i != session[:user_id].to_i && session[:user] != "admin") || current_user == nil
      flash[:warning] = "You do not have admin privileges. Please log-in as an admin to continue."
      redirect_to new_session_path
    end
    @student_updating = Student.find(id)
    
    if @current_user = Student.find_by_id(session[:user_id]).try(:authenticate, params[:student][:password]) || (session[:user] == "admin" && Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password]))
      if @student_updating.update_attributes(student_params_edit)
        flash[:notice] = "#{@student_updating.email} -- #{@student_updating.name} was successfully updated."
        redirect_to edit_student_path
      else
        flash[:notice] = "Failed to save update. Invalid Email."
        redirect_to :action => 'edit', :id => params[:student][:id] , :method => :get
      end
    else
      flash[:notice] = "Incorrect Password"
      redirect_to :action => 'edit', :id => params[:student][:id] , :method => :get
    end
  end
  
  def remove
    id = params[:id]
    if (id.to_i != session[:user_id].to_i && session[:user] != "admin") || current_user == nil
      flash[:warning] = "You do not have admin privileges. Please log-in as an admin to continue."
      redirect_to new_session_path
    end
    @user_removing = Student.find_by_id(id)
    @current_user = current_user
  end
  
  def destroy
    id = params[:id]
    if (id.to_i != session[:user_id].to_i && session[:user] != "admin") || current_user == nil
      flash[:warning] = "You do not have admin privileges. Please log-in as an admin to continue."
      redirect_to new_session_path
    end
    
    removed_user = Student.find_by_id(id)
    if Student.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password]) || session[:user] == "admin"
      Student.find_by_id(id).destroy
      if session[:user_id] == id
        flash[:notice] = "#{@current_user.email} -- #{@current_user.name} was successfully deleted. This was your account."
        session[:user_id] = nil
        redirect_to '/createaccount'
      else
        flash[:notice] = "#{removed_user.email} -- #{removed_user.name} was successfully deleted."
        redirect_to  :controller => 'home', :action => 'index'
      end
    else
      flash[:notice] = "Incorrect Password!"
      redirect_to :action => 'remove', :id => id , :method => :get
    end
  end
  
  private def student_params_create
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end
  
  private def student_params_edit
    params.require(:student).permit(:name, :email, :password)
  end
  
end

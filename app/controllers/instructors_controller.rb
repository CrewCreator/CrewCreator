class InstructorsController < ApplicationController
  before_action :is_admin, only: [:create, :new, :remove, :destroy]
    
  def index
    @instructors = Instructor.all
  end
  
  def new
     @instructor = Instructor.new
  end
  
 def create
    @instructor = Instructor.new(student_params_create)
    if @instructor.save
      flash[:notice] = "#{@instructor.email} -- #{@instructor.name} was successfully created."
      if !current_user
        session[:user_id] = @instructor.id
        session[:user] = "instructor"
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
    @student = Instructor.find(id)
  end
  
  def update
    id = params[:id]
    if (id.to_i != session[:user_id].to_i && session[:user] != "admin") || current_user == nil
      flash[:warning] = "You do not have admin privileges. Please log-in as an admin to continue."
      redirect_to new_session_path
    end
    @student_updating = Instructor.find(id)
    
    if @current_user = Instructor.find_by_id(session[:user_id]).try(:authenticate, params[:student][:password]) || session[:user] == "admin"
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
    @user_removing = Instructor.find_by_id(id)
    @current_user = current_user
  end
  
  def destroy
    id = params[:id]
    if (id.to_i != session[:user_id].to_i && session[:user] != "admin") || current_user == nil
      flash[:warning] = "You do not have admin privileges. Please log-in as an admin to continue."
      redirect_to new_session_path
    end
    
    removed_user = Instructor.find_by_id(id)
    if Instructor.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password]) || session[:user] == "admin"
      Instructor.find_by_id(id).destroy
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
  
  private def instructor_params_create
    params.require(:instructor).permit(:name, :email, :password, :password_confirmation)
  end
  
  private def instructor_params_edit
    params.require(:instructor).permit(:name, :email, :password)
  end
end

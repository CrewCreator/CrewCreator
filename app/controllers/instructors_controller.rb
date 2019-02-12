class InstructorsController < ApplicationController
  before_action :is_admin, only: [:index, :create, :new, :remove, :destroy]
    
  def index
    @instructors = Instructor.all
  end
  
  def new
     @instructor = Instructor.new
  end
  
 def create
    @instructor = Instructor.new(instructor_params_create)
    if @instructor.save
      flash[:notice] = "#{@instructor.email} -- #{@instructor.name} was successfully created."
      redirect_to instructors_path
    else
      flash[:notice] = "Email was taken or password did not meet specifications!"
      redirect_to '/instructors/new'
    end
  end
  
  def edit
    id = params[:id]
    if (id.to_i != session[:user_id].to_i && session[:user] == "instructor") || current_user == nil || (session[:user] != "admin" && session[:user] != "instructor")
      flash[:warning] = "You do not have admin privileges. Please log-in as an admin to continue."
      redirect_to new_session_path
    end
    @instructor = Instructor.find(id)
  end
  
  def update
    id = params[:id]
    if (id.to_i != session[:user_id].to_i && session[:user] == "instructor") || current_user == nil || (session[:user] != "admin" && session[:user] != "instructor")
      flash[:warning] = "You do not have admin privileges. Please log-in as an admin to continue."
      redirect_to new_session_path
    end
    @instructor_updating = Instructor.find(id)
    
    if @current_user = Instructor.find_by_id(session[:user_id]).try(:authenticate, params[:instructor][:password]) || session[:user] == "admin"
      if @instructor_updating.update_attributes(instructor_params_edit)
        flash[:notice] = "#{@instructor_updating.email} -- #{@instructor_updating.name} was successfully updated."
        redirect_to edit_instructor_path
      else
        flash[:notice] = "Failed to save update. Invalid Email."
        redirect_to :action => 'edit', :id => params[:instructor][:id] , :method => :get
      end
    else
      flash[:notice] = "Incorrect Password"
      redirect_to :action => 'edit', :id => params[:instructor][:id] , :method => :get
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
    if Instructor.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password]) || (session[:user] == "admin" && Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password]))
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

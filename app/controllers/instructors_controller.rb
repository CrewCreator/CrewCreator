class InstructorsController < ApplicationController
  before_action :is_admin, only: [:index, :new, :create]
  before_action :super_access, only: [:edit, :update, :remove, :destroy]
  before_action :me_instructor, only: [:edit, :update, :remove, :destroy]
    
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
      flash[:warning] = "Email was taken or password did not meet specifications!"
      redirect_to '/instructors/new'
    end
  end
  
  def edit
    id = params[:id]
    @instructor = Instructor.find(id)
  end
  
  def update
    id = params[:id]
    @instructor_updating = Instructor.find(id)
    
    if @current_user = Instructor.find_by_id(session[:user_id]).try(:authenticate, params[:instructor][:password]) || (session[:user] == "admin" && Admin.find_by_id(session[:user_id]).try(:authenticate, params[:instructor][:password]))
      if @instructor_updating.update_attributes(instructor_params_edit)
        flash[:notice] = "#{@instructor_updating.email} -- #{@instructor_updating.name} was successfully updated."
        if session[:user] == "admin"
          redirect_to instructors_path
        else
          redirect_to edit_instructor_path(id)
        end
      else
        flash[:warning] = "Failed to save update. Invalid Email."
        redirect_to edit_instructor_path(id)
      end
    else
      flash[:warning] = "Incorrect Password"
      redirect_to edit_instructor_path(id)
    end
  end
  
  def remove
    id = params[:id]
    @user_removing = Instructor.find_by_id(id)
    @current_user = current_user
  end
  
  def destroy
    id = params[:id]
    if params[:admin]
      password = params[:admin][:password]
    else
      password = params[:instructor][:password]
    end
    
    if session[:user] == "admin"
      check = Admin.find_by_id(session[:user_id]).try(:authenticate, password)
    else
      check = Instructor.find_by_id(session[:user_id]).try(:authenticate, password)
    end
    
    removed_user = Instructor.find_by_id(id)
    if check
      Instructor.find_by_id(id).destroy
      if !current_user
        flash[:notice] = "#{removed_user.email} -- #{removed_user.name} was successfully deleted. This was your account."
        session[:user_id] = nil
        redirect_to home_path
      else
        flash[:notice] = "#{removed_user.email} -- #{removed_user.name} was successfully deleted."
        redirect_to instructors_path
      end
    else
      flash[:warning] = "Incorrect Password!"
      redirect_to remove_instructor_path(id)
    end
  end
  
  private def me_instructor(id=params[:id])
    if (id.to_i != session[:user_id].to_i && session[:user] != "admin") || current_user == nil
      flash[:warning] = "Unauthorized action"
      redirect_to new_session_path
      return
    end
  end
  
  private def instructor_params_create
    params.require(:instructor).permit(:name, :email, :password, :password_confirmation)
  end
  
  private def instructor_params_edit
    params.require(:instructor).permit(:name, :email, :password)
  end
end

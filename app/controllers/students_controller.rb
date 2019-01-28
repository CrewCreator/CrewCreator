class StudentsController < ApplicationController
  before_action :is_admin, only: [:index, :remove, :delete]
  
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
        session[:is_admin] = false
      end
      redirect_to home_path
    else
      flash[:notice] = "Email was taken or password did not meet specifications!"
      redirect_to '/createaccount'
    end
  end
  
  def edit
    id = params[:id]
    if id.to_i != session[:user_id].to_i
      redirect_to new_session_path
    end
    @student = Student.find(id)
  end
  
  def update
    id = params[:id]
    if id.to_i != session[:user_id].to_i
      redirect_to new_session_path
    end
    @student_updating = Student.find(id)
    
    if @current_user = Admin.find_by_id(session[:user_id]).try(:authenticate, params[:student][:password])
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
  
  private def student_params_create
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end
  
  private def student_params_edit
    params.require(:student).permit(:name, :email, :password)
  end
  
end

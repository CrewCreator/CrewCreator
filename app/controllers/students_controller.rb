class StudentsController < ApplicationController
  before_action :is_user, only: [:edit, :update, :remove, :destroy]
  
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(student_params_create)
    if @student.save
      flash[:notice] = "#{@student.email} -- #{@student.name} was successfully created."
      if !current_user
        session[:user_id] = @student.id
      end
      redirect_to home_path
    else
      flash[:notice] = "Email was taken or password did not meet specifications!"
      redirect_to '/createaccount'
    end
  end
  
  private def student_params_create
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end
  
end

class SectionsController < ApplicationController
  before_action :is_admin, only: [:new , :create, :edit, :update, :remove, :destroy]
  before_action :is_student, only: [:join]
  
  def new
    @course = Course.find(params[:course_id])
    @section = @course.sections.new
  end
  
  def show
    @section = Section.find(params[:id])
  end
  
  def index 
    @sections = Section.all
  end 
  
  def create
    @course = Course.find(params[:course_id])
    @section = @course.sections.build(section_params)
    if @section.save
      redirect_to courses_path
    else
      render 'new'
    end
  end
  
  def edit
    @section = Section.find(params[:id])
  end
  
  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Section #{@section.number} was successfully updated."
      redirect_to section_projects_path(@section)
    else
      flash[:notice] = "Failed to save update. Check your inputs!"
      render 'edit'
    end
  end
  
  def remove 
    @section = Section.find(params[:id])
  end
  
  def destroy 
    removed_section = Section.find_by_id(params[:admin][:id])
    if Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
      flash[:notice] = "#{removed_section.number} was successfully deleted."
      removed_section.destroy
      redirect_to courses_path
    else
      flash[:notice] = "Incorrect Password!"
      redirect_to :action => 'remove', :id => params[:id], :method => :get
    end 
  end 
  
  def roster
    @section = Section.find(params[:section_id])
  end
  
  def update_roster
    @section = Section.find(params[:section_id])
    # does any roster updating need to happen?
    if params[:section].present? and params[:section][:emails_attributes].present?
      
      params[:section][:emails_attributes].each_pair do |index, email_atr| 
        # email already in roster if id is there and we're not removing it
        if email_atr[:_destroy] == 'false'
          if email_atr[:id].present? #and (email_atr[:_destroy] == 'false')
            email = Email.find_by_id(email_atr[:id])
            # if the user changed email string then we need to remove old and insert new
            if email.email != email_atr[:email]
              @section.emails.delete(email)
              # need to check if the new email exists 
              existing_email = Email.find_by_email(email_atr[:email])
              if existing_email
                @section.emails << existing_email unless @section.emails.include?(existing_email)
                params[:section][:emails_attributes].delete(index)
              else
                params[:section][:emails_attributes][index].delete(:id)
              end
            end
          else
            email = Email.find_by_email(email_atr[:email])
            if email and (email_atr[:_destroy] == 'false')
              @section.emails << email unless @section.emails.include?(email)
              params[:section][:emails_attributes].delete(index)
            end
          end
        else
          # remove student from section if their deleted from roster
          student = Student.find_by_email(email_atr[:email])
          if is_student_in_section(student, @section)
            @section.students.delete(student)
          end
        end
      end
      
      if @section.update_attributes(section_params)
        flash[:notice] = "Section #{@section.number} roster was successfully updated."
        redirect_to section_projects_path(@section)
      else
        render 'roster'
      end
      
    else
      redirect_to section_projects_path(@section)
    end
  end
  
  def join
    @section = Section.find(params[:section_id])
    @student = current_user
    if @section.emails.any? { |sec_email| sec_email.email == @student.email }
      @section.students << @student
      flash[:notice] = "You've successfully joined section #{@section.number} for the course #{@section.course.name}."
    else
      flash[:notice] = "Sorry, you aren't currently enrolled in section #{@section.number} for the course #{@section.course.name}."
    end
    redirect_to section_projects_path(@section)
  end
  
  def leave
    @section = Section.find(params[:section_id])
    @student = current_user
    if is_student_in_section(@student, @section)
      flash[:notice] = "You've successfully left section #{@section.number} for the course #{@section.course.name}."
      @section.students.delete(@student)
    else
      flash[:notice] = "Sorry, you weren't enrolled in section #{@section.number} for the course #{@section.course.name}."
    end
    redirect_to section_projects_path(@section)
  end
  
  private def section_params
    params.require(:section).permit(:number, emails_attributes: [:id, :email, :_destroy])
  end
end

class CoursesController < ApplicationController
  #Add authentication step
  before_action :is_admin, only: [:new]
  
  def index
    @courses = Course.all
  end
  
  def show
    id = params[:id]
    @course = Course.find(id)
  end
  
  def new
      @course = Course.new
  end
  
  def create
    @course = Course.create(params.require(:course).permit(:name, :code, :description))
    if @course.save
      sections_added = ""
      @section = @course.sections.build(sec_params)
      
      if @section.save
        sections_added += "#{params[:section]} "
      else
        render new_course_path
        return
      end

      puts(params)
      flash[:notice] = "#{@course.code} -- #{@course.name} was successfully created with sections#{sections_added}"
      redirect_to courses_path
    else
      if params[:course][:code] != "" and Course.where(code: params[:course][:code]).take
        flash[:warning] = "Must have unique Course Code. #{params[:course][:code]} is already used."
        render new_course_path
      else
        missing_attr = ""
        i = 0
        puts(params)
        Course.new.attributes.keys.each do |var|
          puts(var, i)
          if params[:course][var.to_sym]=="" and i > 2
            puts("add")
            missing_attr += "#{var} "
          end
          i += 1
        end
        flash[:warning] = "#{missing_attr} required for creating a Course."
        render new_course_path
      end
    end
  end
  
  private def req_params
    params.require(:course).permit(:name, :code, :description)
  end
  
  private def sec_params
    params.require(:section).permit(:number)
  end
end

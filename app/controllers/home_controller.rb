class HomeController < ApplicationController
  def index
    if is_admin_html
      @sections = Section
    end
    
    if is_student_html
      @sections = current_user.sections
    end
  end
  
  helper_method :get_years
  private def get_years
    @sections.order(year: :desc).distinct.pluck(:year)
  end
  
  helper_method :get_semesters
  private def get_semesters
    Section.semesters.reverse!
  end
  
  helper_method :does_year_semester_exist
  private def does_year_semester_exist(year, semester)
    @sections.where(year: year, semester: semester).any?
  end
  
  helper_method :get_sections
  private def get_sections(year, semester)
    @sections.where(year: year, semester: semester).order(number: :asc)
  end
end

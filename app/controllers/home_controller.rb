class HomeController < ApplicationController
  def index
    if is_admin_html
      @sections = Section
    end
    
    if is_student_html
      @sections = current_user.sections
    end
  end
end

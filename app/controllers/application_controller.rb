class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  
  helper_method :current_user
    def current_user
      if session[:user_id]
        if session[:user] == "admin"
          if Admin.exists? (session[:user_id])
            @current_user ||= Admin.find(session[:user_id])
          else
            @current_user = nil
          end
        elsif session[:user] == "student"
          if Student.exists? (session[:user_id])
            @current_user ||= Student.find(session[:user_id])
          else
            @current_user = nil
          end
        elsif session[:user] == "instructor"
          if Instructor.exists? (session[:user_id])
            @current_user ||= Instructor.find(session[:user_id])
          else
            @current_user = nil
          end
        else
          @current_user = nil
        end
      else
        @current_user = nil
      end
    end
    
  helper_method :has_section_html
    def has_section_html(id)
      if is_instructor_html && current_user.sections.find_by_id(id) || is_admin_html
        true
      else
        false
      end
    end
  
  helper_method :super_access_html
    def super_access_html
      if is_admin_html || is_instructor_html
        true
      else
        false
      end
    end
    
  helper_method :super_access
    def super_access
      if !is_admin_html && !is_instructor_html
        redirect_to new_session_path
      end
    end
  
  helper_method :is_admin
    def is_admin
      if session[:user] != "admin" || current_user.nil?
        redirect_to controller: 'sessions', action: 'new'
      end
    end
    
  helper_method :is_admin_html
    def is_admin_html
      if session[:user] != "admin" || current_user.nil?
        false
      else
        true
      end
    end
    
  helper_method :is_instructor
    def is_instructor
      if session[:user] != "instructor" || current_user.nil?
        redirect_to controller: 'sessions', action: 'new'
      end
    end
    
  helper_method :is_instructor_html
    def is_instructor_html
      if session[:user] != "instructor" || current_user.nil?
        false
      else
        true
      end
    end
    
  helper_method :is_user_html
    def is_user_html
      if current_user.nil?
        false
      else
        true
      end
    end
    
  helper_method :is_user
    def is_user
      if current_user.nil?
        redirect_to controller: 'sessions', action: 'new'
      end
    end
    
  helper_method :is_student
    def is_student
      if session[:user] != "student" || current_user.nil?
        redirect_to controller: 'sessions', action: 'new'
      end
    end
    
  helper_method :is_student_html
    def is_student_html
      if session[:user] != "student" || current_user.nil?
        false
      else
        true
      end
    end

  helper_method :is_student_in_section
    def is_student_in_section(student, section)
      return section.students.include?(student)
    end
    
  helper_method :is_student_on_team
    def is_student_on_team(student, team)
      return team.students.include?(student)
    end
end

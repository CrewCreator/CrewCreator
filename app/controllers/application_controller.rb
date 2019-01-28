class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  
  helper_method :current_user
    def current_user
      if session[:user_id]
        if Admin.exists? (session[:user_id])
          @current_user ||= Admin.find(session[:user_id])
        elsif Student.exists? (session[:user_id])
          @current_user ||= Student.find(session[:user_id])
        else
          @current_user = nil
        end
      else
        @current_user = nil
      end
    end
    
  helper_method :is_admin
    def is_admin
      if current_user.nil? || !Admin.exists?(session[:user_id])
        redirect_to :controller => 'sessions', :action => 'new'
      end
    end
    
  helper_method :is_admin_html
    def is_admin_html
      if current_user.nil? || !Admin.exists?(session[:user_id])
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
        redirect_to :controller => 'sessions', :action => 'new'
      end
    end
    
end

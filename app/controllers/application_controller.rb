class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  
  helper_method :current_user
    def current_user
      if session[:user_id]
        if Admin.find(session[:user_id])
          @current_user ||= Admin.find(session[:user_id])
        end
      else
        @current_user = nil
      end
    end
    
  helper_method :is_admin
    def is_admin
      if current_user.nil? && !Admin.exists?(session[:user_id])
        redirect_to :controller => 'sessions', :action => 'new'
      end
    end
end
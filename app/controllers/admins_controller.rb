class AdminsController < ApplicationController
    
  def new
     # default: render 'new' template
     @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(project_params)
    if @admin.save
      flash[:notice] = "#{@admin.email} -- #{@admin.name} was successfully created."
      redirect_to  :controller => 'home', :action => 'index'
    else
      # This line overrides the default rendering behavior, which would have been to render the 'create' view.
      render 'new'
    end
  end
  
  def index
    @admins = Admin.all
  end

  private def project_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end
end

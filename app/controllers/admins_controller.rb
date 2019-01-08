class AdminsController < ApplicationController
  before_action :is_admin, only: [:edit, :update]
    
  def new
     # default: render 'new' template
     @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(admin_params_create)
    if @admin.save
      flash[:notice] = "#{@admin.email} -- #{@admin.name} was successfully created."
      redirect_to  :controller => 'home', :action => 'index'
    else
      # This line overrides the default rendering behavior, which would have been to render the 'create' view.
     redirect_to '/createaccount'
    end
  end
  
  def index
    @admins = Admin.all
  end
  
  def edit
    @user = current_user
  end

  def update
    if @user = Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
      if @user.update_attributes(admin_params_edit)
        flash[:notice] = "#{@user.email} -- #{@user.name} was successfully updated."
        redirect_to :action => 'index'
      else
        flash[:notice] = "Failed to save update. Check your inputs!"
        redirect_to '/admin_account'
      end
    else
      flash[:notice] = "Incorrect Password"
      redirect_to '/admin_account'
    end
  end
  
  private def admin_params_create
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end
  
  private def admin_params_edit
    params.require(:admin).permit(:name, :email, :password)
  end
end

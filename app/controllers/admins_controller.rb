class AdminsController < ApplicationController
  before_action :is_admin, only: [:edit, :update, :remove, :destroy]
    
  def index
    @admins = Admin.all
  end
  
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
  
  def edit
    @current_user = current_user
  end

  def update
    if @current_user = Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
      if @current_user.update_attributes(admin_params_edit)
        flash[:notice] = "#{@current_user.email} -- #{@current_user.name} was successfully updated."
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
  
  def remove
    @user_removing = Admin.find_by_id(params[:id])
    @current_user = current_user
  end
  
  def destroy
    if Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
      Admin.find_by_id(params[:admin][:id]).destroy
      flash[:notice] = "Admin deleted"
      if session[:user_id] == params[:admin][:id]
        session[:user_id] = nil
        redirect_to '/createaccount'
      else
        redirect_to  :controller => 'home', :action => 'index'
      end
    else
      redirect_to :action => 'remove', :id => params[:admin][:id] , :method => :get
    end
  end
  
  private def admin_params_create
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end
  
  private def admin_params_edit
    params.require(:admin).permit(:name, :email, :password)
  end
end

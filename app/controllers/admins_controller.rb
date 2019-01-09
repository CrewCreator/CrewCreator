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
    flash[:notice] = "Email was taken or password did not meet specifications!"
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
        flash[:notice] = "Failed to save update. Invalid Email."
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
  
  def confirm
    @current_user = current_user
  end
  
  def destroy
    removed_user = Admin.find_by_id(params[:admin][:id])
    if Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
      Admin.find_by_id(params[:admin][:id]).destroy
      if session[:user_id] == params[:admin][:id]
        flash[:notice] = "#{@current_user.email} -- #{@current_user.name} was successfully deleted. This was your account."
        session[:user_id] = nil
        redirect_to '/createaccount'
      else
        flash[:notice] = "#{removed_user.email} -- #{removed_user.name} was successfully deleted."
        redirect_to  :controller => 'home', :action => 'index'
      end
    else
      flash[:notice] = "Incorrect Password!"
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

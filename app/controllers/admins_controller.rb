class AdminsController < ApplicationController
  before_action :is_admin, only: [:create, :new, :edit, :update, :remove, :destroy]
    
  def index
    @admins = Admin.all
  end
  
  def new
     @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(admin_params_create)
    if @admin.save
      flash[:notice] = "#{@admin.email} -- #{@admin.name} was successfully created."
      if !current_user
        session[:user_id] = @admin.id
        session[:is_admin] = true
      end
      redirect_to controller: 'home', action: 'index'
    else
      # This line overrides the default rendering behavior, which would have been to render the 'create' view.
      flash[:notice] = "Email was taken or password did not meet specifications!"
      redirect_to '/createaccount'
    end
  end
  
  def edit
    @object_updating = current_user
  end

  def update
    if @current_user = Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
      if @current_user.update_attributes(admin_params_edit)
        flash[:notice] = "#{@current_user.email} -- #{@current_user.name} was successfully updated."
      else
        flash[:notice] = "Failed to save update. Invalid Email."
      end
    else
      flash[:notice] = "Incorrect Password"
    end
    redirect_to admin_account_path
  end
  
  def remove
    @user_removing = Admin.find_by_id(params[:id])
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

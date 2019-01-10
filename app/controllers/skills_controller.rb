class SkillsController < ApplicationController
  before_action :is_admin, only: [:new , :create, :edit, :update, :remove, :destroy]
  
  def index
    @skills = Skill.all
  end

  def new
    @skill = Skill.new
  end

  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy

    redirect_to skills_path
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      if session[:form_values]
        session[:form_values]['project']['skill_ids'].push(@skill.id)
        if session[:return_path] == 'patch'
          redirect_to edit_project_path(session[:project_id])
        else
          redirect_to new_section_project_path(session[:return_section])
        end
      else
        redirect_to skills_path
      end
    else
      render 'new'
    end
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])
    if @skill.update_attributes(skill_params)
      redirect_to skill_path(@skill)
    else
      render 'edit'
    end
  end

  private
  def skill_params
    params.require(:skill).permit(:name, :description)
  end

end

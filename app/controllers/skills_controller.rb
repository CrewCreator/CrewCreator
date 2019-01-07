class SkillsController < ApplicationController

  def index
    @skills = Skill.all
  end

  def create
    skill = Skill.create(skill_params)
    redirect_to skills_path
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def destroy
    
  end

  private
  def skill_params
    params.require(:skill).permit(:name)
  end

end

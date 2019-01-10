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
    @skill = Skill.create(skill_params)

    redirect_to skills_path
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])
    @skill.update(skill_params)

    redirect_to skill_path(@skill)
  end

  private
  def skill_params
    params.require(:skill).permit(:name, :description)
  end

end

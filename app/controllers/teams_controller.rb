class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def edit
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  private
  def team_params
    params.require(:team).permit(:name, :description, :created_at, :defined_id, :production_link, :project_management_link,\
                                  :scrum_time, :staging_link, :version_control_link)
  end

  def create
    @team = Team.create(team_params)

    redirect_to teams_path
  end

  def update
    @team = Team.find(params[:id])
    @team.update(team_params)

    redirect_to team_path (@team)
  end

  end



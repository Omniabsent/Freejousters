class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(:title, :description, :wanted_skills, :max_pay, :expiration_date, :remote))
    @project.user = current_user
    if @project.save then
      redirect_to project_path(@project.id)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project = Project.update(params.require(:project).permit(:title, :description, :wanted_skills, :max_pay, :expiration_date, :remote))
    redirect_to user_profile_path
  end

  def show
    id = params[:id]
    @project = Project.find(id)
  end

  def my_projects
    @project = current_user.project
  end

  def all_projects
    @project = Project.all
  end
end

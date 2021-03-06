class ProjectsController < ApplicationController
  before_action :authenticate_user!

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

  #def edit
  #  @project = Project.find(params[:id])
  #end

  #def update
  #  @project = Project.find(params[:id])
  #  @project = Project.update(params.require(:project).permit(:title, :description, :wanted_skills, :max_pay, :expiration_date, :remote))
  #  redirect_to user_profile_path
  #end

  def show
    id = params[:id]
    @project = Project.find(id)
    @proposal = Proposal.new
  end

  def encerrado
    @project = Project.find(params[:id])
    if @project.user == current_user then
      @project.encerrado!
      redirect_to request.referer
    else
      redirect_to root_path, notice: 'Você não tem autorização para encerrar esse projeto'
    end
  end

  def fechado
    @project = Project.find(params[:id])
    if @project.user == current_user then
      @project.fechado!
      redirect_to request.referer
    else
      redirect_to root_path, notice: 'Você não tem autorização para fechar esse projeto'
    end
  end

  def my_projects
    @project = current_user.project
  end

  def all_projects
    @project = Project.all
  end

  def search
    @project = Project.where('title like ? OR description like ?', "%#{params[:q]}%", "%#{params[:q]}%")
  end
end

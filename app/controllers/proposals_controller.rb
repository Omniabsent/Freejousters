class ProposalsController < ApplicationController
  before_action :authenticate_user!

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(params.require(:proposal).permit(:presentation, :charges, :week_hours, :total_hours, :project_id, :approval))
    @proposal.status = 'pending'
    @proposal.user = current_user
    @proposal.project = Project.find(params[:project_id])
    if @proposal.save then
      redirect_to request.referer, notice: 'Você se candidatou a esse projeto'
    else
      redirect_to request.referer, notice: 'Todos os campos devem ser preenchidos'
    end
  end

  def show
    id = params[:id]
    @proposal = Proposal.find(id)
  end

  def cancel
    @proposal = Proposal.find(params[:id])
    if @proposal.status == 'accepted' then
      @project = @proposal.project
      @proposal.cancelled!
      render "proposals/cancel"
    else
      @proposal.cancelled!
      redirect_to request.referer
    end
  end


  def accept
    @proposal = Proposal.find(params[:id])
    @proposal.accepted!
    redirect_to request.referer
  end

  def reject
    @proposal = Proposal.find(params[:id])
    @project = @proposal.project
    @proposal.rejected!
    render "proposals/reject"
  end

  #def edit
  #  @proposal = Proposal.find(params[:id])
  #end

  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(params.require(:proposal).permit(:justification))
    @project = @proposal.project
    redirect_to project_path(@project.id), notice: 'Justificativa enviada'
  end

  def my_proposals
    @project = current_user.project
  end
end

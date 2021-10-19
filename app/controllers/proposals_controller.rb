class ProposalsController < ApplicationController

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(params.require(:proposal).permit(:presentation, :charges, :week_hours, :total_hours, :project_id, :approval))
    @proposal.status = 'pending'
    @proposal.user = current_user
    @proposal.project = Project.find(params[:project_id])
    @proposal.save!

    redirect_to request.referer, notice: 'Você se candidatou a esse projeto'
  end

  def show
    id = params[:id]
    @proposal = Proposal.find(id)
  end

  def accept
    @proposal = Proposal.find(params[:id])
    @proposal.accepted!
    redirect_to request.referer
  end

  def reject
    @proposal = Proposal.find(params[:id])
    @proposal.rejected!
    redirect_to to_rejected_professionals_path
  end

  def proposals_to_my_projects
    @proposal = current_user.proposals.projects
  end

  def my_proposals
    @project = current_user.project
  end
end

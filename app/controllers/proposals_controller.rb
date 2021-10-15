class ProposalsController < ApplicationController

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(params.require(:proposal).permit(:presentation, :charges, :week_hours, :total_hours, :project_id, :approval))
    @proposal.approval = 'pending'
    @proposal.user = current_user
    if @proposal.save then
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    id = params[:id]
    @proposal = Proposal.find(id)
  end

  def proposals_to_my_projects
    @proposal = current_user.proposals.projects
  end

  def my_proposals
    @proposal.user_id = current_user.id
  end
end

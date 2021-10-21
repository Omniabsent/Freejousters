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

  def cancel
    @proposal = Proposal.find(params[:id])
    @proposal.cancelled!
    if @proposal.created_at <= 3.days.ago || @proposal.status == 1 then
      render "proposals/cancel"
    else
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
    @proposal.rejected!
    render "proposals/reject"
  end

  def edit
    @proposal = Proposal.find(params[:id])
  end

  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(params.require(:proposal).permit(:justification))
    redirect_to request.referer
  end

  def my_proposals
    @project = current_user.project
  end
end

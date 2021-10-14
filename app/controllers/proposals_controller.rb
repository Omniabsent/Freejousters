class ProposalsController < ApplicationController

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(params.require(:proposal).permit(:presentation, :charges, :week_hours, :total_hours, :project, :approval))
    @proposal.approval = 'pending'
    @proposal.user = current_user
    @proposal.project = params[:id]
    if @proposal.save then
      redirect_to project_path(@project.id)
    else
      render :new
    end
  end
end

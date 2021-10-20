class FeedbacksToProfessionalsController < ApplicationController

  def to_rejected
    @feedback = FeedbacksToProfessional.new
    @feedback.user = current_user
    proposal = Proposal.find(params[:proposal_id])
    @feedback.professional_id = proposal.user_id
    @feedback.save!

    redirect_to request.referer, notice: 'Mensagem de recusa enviada'
  end

  def create
  end

end

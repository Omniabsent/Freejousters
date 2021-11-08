class ProposalMailer < ApplicationMailer
  def notify_new_proposal
    @proposal = params[:proposal]
    mail(to: @proposal.project.user.email, subject: 'Nova proposta para seu projeto')
  end
end

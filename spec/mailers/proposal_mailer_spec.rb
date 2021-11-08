require 'rails_helper'

RSpec.describe ProposalMailer, type: :mailer do
  context 'new proposal' do
    it 'should notify project owner' do
      professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
      professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
      user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
      user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
      project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
      proposal = Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

      mail = ProposalMailer.with(proposal: proposal).notify_new_proposal()

      expect(mail.to).to include('captain@flint.com')
      expect(mail.from).to include('noreply@freejousters.com')
      expect(mail.subject).to include('Nova proposta para seu projeto')
      expect(mail.body).to include('Olá, seu projeto recebeu uma nova proposta')
    end
  end
end

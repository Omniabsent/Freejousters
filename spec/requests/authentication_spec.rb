require 'rails_helper'

describe 'someone who is not logged in' do
  it 'cannot see profiles' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)

    get '/user_profiles/1'

    expect(response).to redirect_to(user_session_path)
  end

  it 'cannot see projects' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)

    get '/projects/1'

    expect(response).to redirect_to(user_session_path)
  end

  it 'cannot send proposal' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)

    post '/projects/1/proposals'

    expect(response).to redirect_to(user_session_path)
  end
end

describe 'someone who is logged in' do
  it 'tries to finish project from someone else' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    another_user = User.create!(email: 'edward@teach.com', password: '123456', role: 'hirer')
    another_user_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '02/03/1700', picture: 'https://graveyardoftheatlantic.com/wp-content/uploads/2016/11/blackbeard.jpg', user: another_user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)

    login_as another_user, scope: :user
    post encerrado_project_path(1)

    expect(response).to redirect_to(root_path)
    expect(flash[:notice]).to eq("Você não tem autorização para encerrar esse projeto")
  end

  it 'tries to close project from someone else' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    another_user = User.create!(email: 'edward@teach.com', password: '123456', role: 'hirer')
    another_user_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '02/03/1700', picture: 'https://graveyardoftheatlantic.com/wp-content/uploads/2016/11/blackbeard.jpg', user: another_user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)

    login_as another_user, scope: :user
    post fechado_project_path(1)

    expect(response).to redirect_to(root_path)
    expect(flash[:notice]).to eq("Você não tem autorização para fechar esse projeto")
  end

  it 'tries to accept proposal to someone else\'s project' do
    user = User.create!(email: 'captain@flint.com', password: '123456', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/02/1700', picture: 'https://cdna.artstation.com/p/assets/images/images/003/183/004/medium/kseniia-tselousova-543-flint-s.jpg?1470745013', user: user)

    another_user = User.create!(email: 'edward@teach.com', password: '123456', role: 'hirer')
    another_user_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '02/03/1700', picture: 'https://graveyardoftheatlantic.com/wp-content/uploads/2016/11/blackbeard.jpg', user: another_user)

    professional = User.create!(email: 'anne@bonny.com', password: '123456', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Anne Bonny', social_name: 'Adam Bonny', birth_date: '03/04/1700', major: 'Thief', bio: 'You don\'t want to know', experience: 'Member of Calico\'s crew', picture: 'https://64.media.tumblr.com/349863f4fa0d1523364bfc5fe5bce824/tumblr_pkj9ry9qKM1qeu6ilo1_500.jpg', user: professional)

    project = Project.create!(title:'Encontrar e saquear o Urca De Lima', description:'Em busca de uma tripulação capaz de roubar o ouro dos espanhóis', wanted_skills:'Saber ler carta náutica', max_pay: 50, expiration_date:5.days.from_now, user: user)
    Proposal.create!(presentation:'O melhor quartermaster e helmsman desse lado das Bahamas', charges: 50, week_hours: 50, total_hours: 200, project: project, user: professional)

    login_as another_user, scope: :user
    post accept_project_proposal_path(1, 1)

    expect(response).to redirect_to(root_path)
    expect(flash[:notice]).to eq("Você não tem autorização para aceitar essa proposta")
  end

  it 'tries to reject proposal to someone else\'s project' do
    user = User.create!(email: 'captain@flint.com', password: '123456', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/02/1700', picture: 'https://cdna.artstation.com/p/assets/images/images/003/183/004/medium/kseniia-tselousova-543-flint-s.jpg?1470745013', user: user)

    another_user = User.create!(email: 'edward@teach.com', password: '123456', role: 'hirer')
    another_user_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '02/03/1700', picture: 'https://graveyardoftheatlantic.com/wp-content/uploads/2016/11/blackbeard.jpg', user: another_user)

    professional = User.create!(email: 'anne@bonny.com', password: '123456', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Anne Bonny', social_name: 'Adam Bonny', birth_date: '03/04/1700', major: 'Thief', bio: 'You don\'t want to know', experience: 'Member of Calico\'s crew', picture: 'https://64.media.tumblr.com/349863f4fa0d1523364bfc5fe5bce824/tumblr_pkj9ry9qKM1qeu6ilo1_500.jpg', user: professional)

    project = Project.create!(title:'Encontrar e saquear o Urca De Lima', description:'Em busca de uma tripulação capaz de roubar o ouro dos espanhóis', wanted_skills:'Saber ler carta náutica', max_pay: 50, expiration_date:5.days.from_now, user: user)
    Proposal.create!(presentation:'O melhor quartermaster e helmsman desse lado das Bahamas', charges: 50, week_hours: 50, total_hours: 200, project: project, user: professional)

    login_as another_user, scope: :user
    post reject_project_proposal_path(1, 1)

    expect(response).to redirect_to(root_path)
    expect(flash[:notice]).to eq("Você não tem autorização para rejeitar essa proposta")
  end

  it 'tries to cancel someone else\'s proposal' do
    user = User.create!(email: 'captain@flint.com', password: '123456', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/02/1700', picture: 'https://cdna.artstation.com/p/assets/images/images/003/183/004/medium/kseniia-tselousova-543-flint-s.jpg?1470745013', user: user)

    another_user = User.create!(email: 'edward@teach.com', password: '123456', role: 'hirer')
    another_user_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '02/03/1700', picture: 'https://graveyardoftheatlantic.com/wp-content/uploads/2016/11/blackbeard.jpg', user: another_user)

    professional = User.create!(email: 'anne@bonny.com', password: '123456', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Anne Bonny', social_name: 'Adam Bonny', birth_date: '03/04/1700', major: 'Thief', bio: 'You don\'t want to know', experience: 'Member of Calico\'s crew', picture: 'https://64.media.tumblr.com/349863f4fa0d1523364bfc5fe5bce824/tumblr_pkj9ry9qKM1qeu6ilo1_500.jpg', user: professional)

    project = Project.create!(title:'Encontrar e saquear o Urca De Lima', description:'Em busca de uma tripulação capaz de roubar o ouro dos espanhóis', wanted_skills:'Saber ler carta náutica', max_pay: 50, expiration_date:5.days.from_now, user: user)
    Proposal.create!(presentation:'O melhor quartermaster e helmsman desse lado das Bahamas', charges: 50, week_hours: 50, total_hours: 200, project: project, user: professional)

    login_as another_user, scope: :user
    post cancel_project_proposal_path(1, 1)

    expect(response).to redirect_to(root_path)
    expect(flash[:notice]).to eq("Você não tem autorização para cancelar essa proposta")
  end

  it 'tries to send justification' do
    user = User.create!(email: 'captain@flint.com', password: '123456', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/02/1700', picture: 'https://cdna.artstation.com/p/assets/images/images/003/183/004/medium/kseniia-tselousova-543-flint-s.jpg?1470745013', user: user)

    another_user = User.create!(email: 'edward@teach.com', password: '123456', role: 'hirer')
    another_user_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '02/03/1700', picture: 'https://graveyardoftheatlantic.com/wp-content/uploads/2016/11/blackbeard.jpg', user: another_user)

    professional = User.create!(email: 'anne@bonny.com', password: '123456', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Anne Bonny', social_name: 'Adam Bonny', birth_date: '03/04/1700', major: 'Thief', bio: 'You don\'t want to know', experience: 'Member of Calico\'s crew', picture: 'https://64.media.tumblr.com/349863f4fa0d1523364bfc5fe5bce824/tumblr_pkj9ry9qKM1qeu6ilo1_500.jpg', user: professional)

    project = Project.create!(title:'Encontrar e saquear o Urca De Lima', description:'Em busca de uma tripulação capaz de roubar o ouro dos espanhóis', wanted_skills:'Saber ler carta náutica', max_pay: 50, expiration_date:5.days.from_now, user: user)
    Proposal.create!(presentation:'O melhor quartermaster e helmsman desse lado das Bahamas', charges: 50, week_hours: 50, total_hours: 200, project: project, user: professional)

    login_as another_user, scope: :user
    patch project_proposal_path(1, 1)

    expect(response).to redirect_to(root_path)
    expect(flash[:notice]).to eq("Você não tem autorização para realizar essa ação")
  end
end

require 'rails_helper'

describe 'someone who is not logged in' do
  it 'tries to see a user profile' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)

    visit 'http://localhost:3000/user_profiles/1'

    expect(page).to_not have_content('Flint')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it 'tries to see a project' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    Project.create!(title:'Saquear o Urca de Lima', description:'Procuro piratas qualificados para atacar e roubar o ouro dos espanhóis', wanted_skills:'Saber operar canhão, lutar com pistola e espada, ler mapas', max_pay: 99999, expiration_date:'01-01-1700', user: user)

    visit 'http://localhost:3000/projects/1'

    expect(page).to_not have_content('Saquear o Urca de Lima')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end


describe 'someone who is logged in as a hirer' do
  it 'tries to see a project from another hirer' do
    user = User.create!(email: 'captain@flint.com', password: '123456', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/02/1700', picture: 'https://cdna.artstation.com/p/assets/images/images/003/183/004/medium/kseniia-tselousova-543-flint-s.jpg?1470745013', user: user)
    project = Project.create!(title:'Encontrar e saquear o Urca De Lima', description:'Em busca de uma tripulação capaz de roubar o ouro dos espanhóis', wanted_skills:'Saber ler carta náutica', max_pay: 50, expiration_date:5.days.from_now, user: user)

    another_user = User.create!(email: 'edward@teach.com', password: '123456', role: 'hirer')
    another_user_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '02/03/1700', picture: 'https://graveyardoftheatlantic.com/wp-content/uploads/2016/11/blackbeard.jpg', user: another_user)
    another_project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: another_user)

    login_as another_user, scope: :user
    visit 'http://localhost:3000/projects/1'

    expect(page).to have_content('Você não possui autorização para visualizar este projeto')
  end
end

describe 'someone who is logged in as a professional' do
  it 'cannot close a project' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

    login_as professional, scope: :user
    visit 'http://localhost:3000/projects/1'

    expect(page).to_not have_content('Fechar projeto')
    expect(page).to_not have_content('Encerrar projeto')
  end

  it 'cannot see proposal from another professional' do
    user = User.create!(email: 'captain@flint.com', password: '123456', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/02/1700', picture: 'https://cdna.artstation.com/p/assets/images/images/003/183/004/medium/kseniia-tselousova-543-flint-s.jpg?1470745013', user: user)
    professional = User.create!(email: 'anne@bonny.com', password: '123456', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Anne Bonny', social_name: 'Adam Bonny', birth_date: '03/04/1700', major: 'Thief', bio: 'You don\'t want to know', experience: 'Member of Calico\'s crew', picture: 'https://64.media.tumblr.com/349863f4fa0d1523364bfc5fe5bce824/tumblr_pkj9ry9qKM1qeu6ilo1_500.jpg', user: professional)
    another_professional =  User.create!(email: 'jack@rackam.com', password: '123456', role: 'hireable')
    another_professional_profile = UserProfile.create!(name: 'Jack Rackham', social_name: 'Calico Jack', birth_date: '04/05/1700', major: 'Fighting & Plundering', bio: 'The inventor of the Jolly Rogers', experience: 'Several years on the crew under captain Charles Vane', picture: 'https://assassinscreedcenter.files.wordpress.com/2013/10/piratas-calico-jack-rackham.jpg', user: another_professional)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Proposal.create!(presentation:'O melhor quartermaster e helmsman desse lado das Bahamas', charges: 50, week_hours: 50, total_hours: 200, project: project, user: professional)
    Proposal.create!(presentation:'I sure can fight', charges: 80, week_hours: 50, total_hours: 300, project: project, user: another_professional)

    login_as professional, scope: :user
    visit 'http://localhost:3000/projects/1'

    expect(page).to have_content('Proposta de: Adam Bonny')
    expect(page).to_not have_content('Proposta de: Calico Jack')
  end
end

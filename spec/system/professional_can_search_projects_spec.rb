require 'rails_helper'

describe 'professional searchs for project' do
  it 'and sees results' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    user_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Project.create!(title:'Saquear o Urca de Lima', description:'Procuro piratas qualificados para atacar e roubar o ouro dos espanhóis', wanted_skills:'Saber operar canhão, lutar com pistola e espada, ler mapas', max_pay: 99999, expiration_date:10.days.from_now, user: user)

    login_as professional, scope: :user
    visit root_path
    click_on 'Projetos disponíveis'
    fill_in 'Busca:', with: 'Salvar'
    click_on 'Pesquisar'

    expect(page).to have_link('Salvar Nassau')
    expect(page).to_not have_link('Saquear Urca de Lima')
  end

  it 'and propose to work on a project' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    user_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Project.create!(title:'Saquear o Urca de Lima', description:'Procuro piratas qualificados para atacar e roubar o ouro dos espanhóis', wanted_skills:'Saber operar canhão, lutar com pistola e espada, ler mapas', max_pay: 99999, expiration_date:10.days.from_now, user: user)

    login_as professional
    visit root_path
    click_on 'Projetos disponíveis'
    click_on 'Salvar Nassau'
    fill_in 'Apresentação', with: 'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar'
    fill_in 'Custo', with: 100
    fill_in 'Horas semanais disponíveis', with: 168
    fill_in 'Total de horas estimadas', with: 48
    click_on 'Enviar'

    expect(page).to have_content('Você se candidatou a esse projeto')
  end

  it 'and, if approved, they can browse the profiles of the team' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    another_professional =  User.create!(email: 'jack@rackam.com', password: 'asdfasdf', role: 'hireable')
    another_professional_profile = UserProfile.create!(name: 'Jack Rackham', social_name: 'Calico Jack', birth_date: '01/01/1700', major: 'Buccaneer', bio: 'Proud quartermaster of Charles Vane', experience: 'Several years on the crew of the Silence', picture: 'calico.jpg', user: another_professional)
    rejected_professional = User.create!(email: 'mark@read.com', password: 'asdfasdf', role: 'hireable')
    rejected_professional_profile = UserProfile.create!(name: 'Mary Read', social_name: 'Mark Read', birth_date: '01/01/1700', major: 'Thief', bio: 'You don\'t want to know', experience: 'Member of Calico\'s crew', picture: 'read.jpg', user: rejected_professional)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional, status: 1)
    Proposal.create!(presentation:'O melhor quartermaster e helmsman desse lado das Bahamas', charges: 50, week_hours: 50, total_hours: 200, project: project, user: another_professional, status: 1 )
    Proposal.create!(presentation:'I sure can fight', charges: 80, week_hours: 50, total_hours: 300, project: project, user: rejected_professional, status: 2 )

    login_as professional
    visit root_path
    click_on 'Projetos disponíveis'
    click_on 'Salvar Nassau'

    expect(page).to have_link('Blackbeard')
    expect(page).to have_link('Calico Jack')
    expect(page).to_not have_link('Mark Read')
  end
end

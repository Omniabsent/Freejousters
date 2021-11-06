require 'rails_helper'

describe 'hirer can close a project' do
  it 'by terminating it' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    #project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    project = create(:project, user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Salvar Nassau'
    click_on 'Encerrar projeto'

    expect(page).to have_content('Status do projeto: encerrado')
  end

  it 'and a terminated project no longer shows in the available projects page' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user, status: 2)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

    login_as professional, scope: :user
    visit root_path
    click_on 'Projetos disponíveis'

    expect(page).to_not have_link('Salvar Nassau')
  end

  it 'by closing it to new proposals' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user, status: 1)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

    login_as user, scope: :user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Salvar Nassau'
    click_on 'Fechar inscrições para o projeto'

    expect(page).to_not have_link('Fechar inscrições para o projeto')
    expect(page).to have_link('Encerrar projeto')
  end

  it 'and a close to proposals project no longer shows in the available projects page' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user, status: 3)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

    login_as professional, scope: :user
    visit root_path
    click_on 'Projetos disponíveis'

    expect(page).to_not have_link('Salvar Nassau')
  end

  it 'but it still shows in "projects i\'m working on" to people who are already working on it' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user, status: 3)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

    login_as professional, scope: :user
    visit root_path
    click_on 'Projetos que me candidatei'

    expect(page).to have_link('Salvar Nassau')
  end

end

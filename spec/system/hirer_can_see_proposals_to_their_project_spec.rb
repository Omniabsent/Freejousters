require 'rails_helper'

describe 'hirer sees proposals to their project' do
  it 'successfully' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

    login_as user, scope: :user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Salvar Nassau'

    expect(page).to have_content('Candidatos:')
    expect(page).to have_content("Proposta de: #{professional_profile.social_name}")
    expect(page).to have_link('Aprovar')
    expect(page).to have_link('Rejeitar')
  end

  it 'and browse the candidate profile' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user, status: 2)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

    login_as user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Salvar Nassau'
    click_on 'Blackbeard'

    expect(page).to have_content('Projetos anteriores:')
    expect(page).to have_link('Salvar Nassau')

  end

  it 'and mark it as a featured candidate' do

  end

  it 'and approves one candidate' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

    login_as user, scope: :user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Salvar Nassau'
    click_on "Aprovar #{professional_profile.social_name}"

    expect(page).to have_content("Proposta de #{professional_profile.social_name} accepted")
  end

  it 'and refuses one candidate and send justification' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

    login_as user, scope: :user
    visit root_path
    click_on 'Meus projetos'
    click_on 'Salvar Nassau'
    click_on "Rejeitar #{professional_profile.social_name}"

    expect(page).to have_content("Proposta de #{professional_profile.social_name} rejected")
    expect(page).to have_content("Motivo da rejeição:")
  end

  it 'and the candidate can see the refusal justification' do

  end

  it 'and the candidate can cancel proposal before accepted' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional)

    login_as professional
    visit root_path
    click_on 'Projetos que me candidatei'
    click_on 'Salvar Nassau'
    click_on 'Cancelar proposta'

    expect(page).to have_content("Proposta de #{professional_profile.social_name} cancelled")
  end

  it 'and the candidate can cancel proposal after approval and send justification' do

  end

  it 'and the candidate cannot cancel proposal more than 3 days after it was approved' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    professional_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Proposal.create!(presentation:'Sou um dos piratas mais temidos do novo mundo e considero Nassau meu verdadeiro lar', charges: 100, week_hours: 10, total_hours: 20, project: project, user: professional, status: 1, updated_at: 4.days.ago)

    login_as professional
    visit root_path
    click_on 'Projetos que me candidatei'
    click_on 'Salvar Nassau'

    expect(page).to_not have_content("Cancelar proposta")
  end
end

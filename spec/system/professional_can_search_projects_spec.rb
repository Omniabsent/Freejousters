require 'rails_helper'

describe 'professional searchs for project' do
  it 'and sees results' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    user_profile = UserProfile.create(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Project.create!(title:'Saquear o Urca de Lima', description:'Procuro piratas qualificados para atacar e roubar o ouro dos espanhóis', wanted_skills:'Saber operar canhão, lutar com pistola e espada, ler mapas', max_pay: 99999, expiration_date:10.days.from_now, user: user)

    login_as user
    visit root_path
    click_on 'Projetos disponíveis'
    fill_in 'Busca:', with: 'Salvar'
    click_on 'Pesquisar'

    expect(page).to have_link('Salvar Nassau')
    expect(page).to_not have_link('Saquear Urca de Lima')
  end

  it 'and propose to work on a project' do
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    user_profile = UserProfile.create(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
    Project.create!(title:'Saquear o Urca de Lima', description:'Procuro piratas qualificados para atacar e roubar o ouro dos espanhóis', wanted_skills:'Saber operar canhão, lutar com pistola e espada, ler mapas', max_pay: 99999, expiration_date:10.days.from_now, user: user)

    login_as user
    visit root_path
    click_on 'Projetos disponíveis'
    click_on 'Salvar Nassau'
    click_on 'Candidatar-se'
    
  end
end

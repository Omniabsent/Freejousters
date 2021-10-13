require 'rails_helper'

describe 'Hirer creates project' do
  it 'and sees project page' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')

    login_as user, scope: :user
    visit root_path
    click_on 'Criar novo projeto'
    fill_in 'Nome do projeto', with: 'Saquear o Urca de Lima'
    fill_in 'Descrição', with: 'Procuro piratas qualificados para atacar e roubar o ouro dos espanhóis'
    fill_in 'Skills necessárias', with: 'Saber operar canhão, lutar com pistola e espada, ler mapas'
    fill_in 'Valor máximo oferecido [hora]', with: 99999
    fill_in 'Data limite para início', with: '01-01-1700'
    click_on 'Enviar'

    expect(page).to have_content('Saquear o Urca de Lima')
    expect(page).to have_content('Procuro piratas qualificados para atacar e roubar o ouro dos espanhóis')
    expect(page).to have_content('Saber operar canhão, lutar com pistola e espada, ler mapas')
    expect(page).to_not have_content('remoto')
  end

  it 'and it shows in their "my projects" list' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    Project.create!(title:'Saquear o Urca de Lima', description:'Procuro piratas qualificados para atacar e roubar o ouro dos espanhóis', wanted_skills:'Saber operar canhão, lutar com pistola e espada, ler mapas', max_pay: 99999, expiration_date:'01-01-1700', user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Meus projetos'

    expect(page).to have_content('Saquear o Urca de Lima')
  end

  it 'and it does not appear on the available list after expired' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')

    login_as user, scope: :user
    visit root_path
    Project.create!(title:'Saquear o Urca de Lima', description:'Procuro piratas qualificados para atacar e roubar o ouro dos espanhóis', wanted_skills:'Saber operar canhão, lutar com pistola e espada, ler mapas', max_pay: 99999, expiration_date:'01-01-1700', user: user)

    click_on 'Projetos disponíveis'

    expect(page).to_not have_content('Saquear o Urca de Lima')
  end

  it 'and professional can browse it' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    professional = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    user_profile = UserProfile.create(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: professional)
    Project.create!(title:'Saquear o Urca de Lima', description:'Procuro piratas qualificados para atacar e roubar o ouro dos espanhóis', wanted_skills:'Saber operar canhão, lutar com pistola e espada, ler mapas', max_pay: 99999, expiration_date:10.days.from_now, user: user)


    login_as professional, scope: :user
    visit root_path
    click_on 'Projetos disponíveis'

    expect(page).to have_link('Saquear o Urca de Lima')
  end
end

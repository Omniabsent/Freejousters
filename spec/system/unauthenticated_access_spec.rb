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

  it 'tries to send proposal' do
    
  end
end


describe 'someone who is logged in as a hirer' do
  it 'tries to see a project from another hirer' do
  end

  it 'tries to close a project from another hirer' do
  end

  it 'tries to approve proposal from a professional to someone else\'s project' do
  end
end

describe 'someone who is logged in as a professional' do
  it 'tries to close a project' do
  end

  it 'tries to cancell proposal from another professional' do
  end
end

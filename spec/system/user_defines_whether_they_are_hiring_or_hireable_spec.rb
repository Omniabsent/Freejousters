require 'rails_helper'

describe 'After loging in, the user' do
  it 'defines they are hiring' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf')

    login_as user, scope: :user
    visit root_path
    click_on 'Tenho um projeto e procuro alguém para criá-lo'

    expect(page).to have_content('Usuário configurado como contratante')
  end

  it 'and sees project creation options' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')

    login_as user, scope: :user
    visit root_path

    expect(page).to have_link('Criar novo projeto')
  end

  it 'defines they are for hire' do
    user = User.create!(email: 'john@silver.com', password: 'asdfasdf')

    login_as user, scope: :user
    visit root_path
    click_on 'Tenho uma skill e procuro um projeto onde usá-la'

    expect(page).to have_text('Usuário configurado como profissional')

  end

  it 'and sees profile creating options' do
    user = User.create!(email: 'john@silver.com', password: 'asdfasdf', role: 'hireable')

    login_as user, scope: :user
    visit root_path

    expect(page).to have_link('Criar perfil profissional')
  end
end

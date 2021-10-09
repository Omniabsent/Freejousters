require 'rails_helper'

describe 'After loging in, the user' do
  it 'defines they are hiring' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf')

    visit root_path
    #login_as user, scope: :user
    #substituto temporário pro login_as user não estar funcionando
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    #
    click_on 'Tenho um projeto e procuro alguém para criá-lo'

    expect(page).to have_content('Usuário configurado como contratante')
  end

  it 'and sees project creation options' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')

    visit root_path
    #substituto temporário pro login_as user não estar funcionando
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    #

    expect(page).to have_link('Criar novo projeto')
  end

  it 'defines they are for hire' do
    user = User.create!(email: 'john@silver.com', password: 'asdfasdf')

    visit root_path
    #login_as user
    #substituto temporário pro login_as user não estar funcionando
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    #
    click_on 'Tenho uma skill e procuro um projeto onde usá-la'

    expect(page).to have_text('Usuário configurado como profissional')

  end

  it 'and sees profile creating options' do
    user = User.create!(email: 'john@silver.com', password: 'asdfasdf', role: 'hireable')

    visit root_path
    #substituto temporário pro login_as user não estar funcionando
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    #

    expect(page).to have_link('Criar perfil profissional')
  end
end

require 'rails_helper'

describe 'professional logs in' do
  it 'and has to file profile before anything else' do
    user = User.create!(email: 'anne@bonny.com', password: 'asdfasdf', role: 'hireable')

    login_as user
    visit root_path

    expect(page).to have_link('Criar perfil profissional')
    expect(page).not_to have_link('Procurar novos projetos')
  end

  it 'and creates profile' do
    user = User.create!(email: 'mark@read.com', password: 'asdfasdf', role: 'hireable')

    login_as user
    visit root_path
    click_on 'Criar perfil profissional'
    fill_in 'Nome', with: 'Mary Read'
    fill_in 'Nome social', with: 'Mark Read'
    fill_in 'Nascimento', with: '01/01/1700'
    fill_in 'Formação', with: 'Pirate'
    fill_in 'Descrição', with: 'Hunting and being hunted along Calico and Anne'
    fill_in 'Experiência', with: 'Dozens of ships looted and privateers killed'
    fill_in 'Foto [link]', with: 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f5/Mary_Read.jpg/800px-Mary_Read.jpg'
    click_on 'Enviar'

    expect(page).not_to have_link('Criar perfil profissional')
    expect(page).to have_link('Projetos disponíveis')
  end

  it 'and edits profile' do
    user = User.create!(email: 'edward@teach.com', password: 'asdfasdf', role: 'hireable')
    user_profile = UserProfile.create(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '01/01/1700', major: 'Captain', bio: 'The Scourge Of The Seven Seas', experience: 'Over a decade as the captain of the Queen Anne', picture: 'blackbeard.jpg', user: user)

    login_as user
    visit root_path
    click_on 'Meu perfil'
    click_on 'Modificar meu perfil'
    fill_in 'Experiência', with: 'Captain and helmsman of the Queen Anne\'s Revenge for over 15 years'
    click_on 'Editar'

    expect(page).to have_content('Captain and helmsman of the Queen Anne\'s Revenge for over 15 years')
  end
end

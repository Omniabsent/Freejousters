require 'rails_helper'

describe 'professional logs in' do
  it 'and has to file profile' do
    user = User.create!(email: 'anne@bonny.com', password: 'asdfasdf', role: 'hireable')

    login_as user
    visit root_path

    expect(page).to have_link('Criar perfil profissional')
  end
end

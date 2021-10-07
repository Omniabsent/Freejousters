require 'rails_helper'

describe 'User logs in' do
  it 'successfully' do
      user = User.create!(email: 'john@silver.com', password: 'asdfasdf')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'

      expect(page).to have_content('Signed in successfully')
      expect(page).to have_link('Logout')
      expect(page).to_not have_link('Login')
  end

  it 'and then logs out' do
      user = User.create!(email: 'john@silver.com', password: 'asdfasdf')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      click_on 'Logout'

      expect(page).to have_content('Signed out successfully')
      expect(page).to_not have_link('Logout')
      expect(page).to have_link('Entrar')
  end
end

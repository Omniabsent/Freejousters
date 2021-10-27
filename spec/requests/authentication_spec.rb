require 'rails_helper'

describe 'someone who is not logged in' do
  it 'cannot see profiles' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)

    get '/user_profiles/1'

    expect(response).to redirect_to(user_session_path)
  end

  it 'cannot see projects' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)

    get '/projects/1'

    expect(response).to redirect_to(user_session_path)
  end

  it 'cannot send proposal' do
    user = User.create!(email: 'captain@flint.com', password: 'asdfasdf', role: 'hirer')
    user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/01/1700', picture: 'flint.jpg', user: user)
    project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)

    post '/projects/1/proposals'

    expect(response).to redirect_to(user_session_path)
  end
end

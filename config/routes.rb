Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get '/about', to: 'home#about'
  post '/hirer', to: 'home#hirer'
  post '/hireable', to: 'home#hireable'

end

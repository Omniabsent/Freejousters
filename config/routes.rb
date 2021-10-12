Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get '/about', to: 'home#about'
  post '/hirer', to: 'user#hirer'
  post '/hireable', to: 'user#hireable'
  resources :user_profiles
  resources :users
  #get '/user_profile/profile', to: 'user_profile#profile'
  #post '/user_profile/profile', to: 'user_profile#new'
end

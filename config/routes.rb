Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get '/about', to: 'home#about'
  post '/hirer', to: 'user#hirer'
  post '/hireable', to: 'user#hireable'
  resources :user_profiles
  resources :users
  resources :projects
  get '/my_projects', to: 'projects#my_projects'
  get '/all_projects', to: 'projects#all_projects'
  #get '/user_profile/profile', to: 'user_profile#profile'
  #post '/user_profile/profile', to: 'user_profile#new'
  get 'search', to: "projects#search"
  resources :proposals
  get '/my_proposals', to: 'proposals#my_proposals'
  get '/proposals_to_my_projects', to: 'proposals#proposals_to_my_projects'
end

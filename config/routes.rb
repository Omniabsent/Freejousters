Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get '/about', to: 'home#about'
  post '/hirer', to: 'user#hirer'
  post '/hireable', to: 'user#hireable'
  resources :user_profiles
  resources :users, only: [:show]
  resources :projects, only: [:new, :create, :show] do
    resources :proposals, only: [:show, :new, :create, :index] do
      post 'accept', on: :member
      post 'reject', on: :member
    end
    post 'encerrado', on: :member
  end
  get '/my_projects', to: 'projects#my_projects'
  get '/all_projects', to: 'projects#all_projects'
  get 'search', to: "projects#search"
  get '/my_proposals', to: 'proposals#my_proposals'
  get '/proposals_to_my_projects', to: 'proposals#proposals_to_my_projects'
  resources :feedbacks_to_professionals
  get '/to_rejected_professional', to: 'feedbacks_to_professionals#to_rejected_professional'
end

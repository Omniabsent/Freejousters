Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get '/about', to: 'home#about'
  post '/hirer', to: 'user#hirer'
  post '/hireable', to: 'user#hireable'
  resources :user_profiles
  resources :users, only: [:show]
  resources :projects, only: [:new, :create, :show, :edit, :update] do
    resources :proposals, only: [:show, :new, :create, :index, :edit, :update] do
      post 'accept', on: :member
      post 'reject', on: :member
      post 'cancel', on: :member
    end
    post 'encerrado', on: :member
    post 'fechado', on: :member
  end
  get '/my_projects', to: 'projects#my_projects'
  get '/all_projects', to: 'projects#all_projects'
  get '/my_proposals', to: 'proposals#my_proposals'
  get '/proposals/reject', to: 'proposals#reject'
  get '/proposals/cancel', to: 'proposals#cancel'
  get 'search', to: "projects#search"
  resources :favourites, only: [:new, :create, :destroy]
end

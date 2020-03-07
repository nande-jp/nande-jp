Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  get 'errors/not_found'
  get 'errors/internal_server_error'
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'top#index'

  resources :questions, shallow: true do
    resources :answers, only: [:create]
  end

  scope module: 'questions' do
    resources :ages, only: :show, path: '/questions/ages'
  end

  resources :categories

  resources :answers, only: [] do
    resources :bookmarks, only: [:create]
    resources :bookmark_deletions, only: [:create]
    resources :shares, only: [:create]
    resources :unshares, only: [:create]
  end

  resources :users do
    resources :bookmarks, only: [:index]
    resources :shares, only: [:index]
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end

  resources :onboarding

  get 'privacy', to: 'pages#privacy'
  get 'terms', to: 'pages#terms'

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end

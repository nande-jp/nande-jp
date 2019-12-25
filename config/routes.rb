Rails.application.routes.draw do
  devise_for :users

  root to: 'top#index'

  resources :questions, shallow: true do
    resources :answers, only: [:create]
  end

  resources :answers, only: [] do
    resources :bookmarks, only: [:create]
    resources :bookmark_deletions, only: [:create]
  end

  resources :users do
    resources :bookmarks, only: [:index]
  end
end

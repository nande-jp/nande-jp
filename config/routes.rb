Rails.application.routes.draw do
  devise_for :users

  root to: 'top#index'

  resources :questions, shallow: true do
    resources :answers, only: [:create]
  end

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
end

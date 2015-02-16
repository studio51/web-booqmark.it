Rails.application.routes.draw do

  root to: 'bookmarks#index'

  devise_for :users,
    controllers: {
      registrations: 'registrations'
    }

  resources :users

  resources :feeds, only: [:index]
  resources :lists

  resources :collections
  resources :bookmarks do
    member do
      get 'regenerate', to: 'bookmarks#regenerate'
    end
  end

  resources :tags, only: [:index, :show, :edit], controller: :bookmarks, action: :index
end

Rails.application.routes.draw do

  root controller: :landings, action: :index

  resources :users

  devise_for :users,
    controllers: {
      registrations: 'registrations',
      omniauth_callbacks: 'omniauth_callbacks'
    }

  resources :feeds, only: [:index]
  resources :lists, only: [:index]

  resources :collections
  resources :bookmarks do
    member do
      get 'regenerate', to: 'bookmarks#regenerate'
    end
  end

  resources :tags, only: [:index, :show, :edit], controller: :bookmarks, action: :index
end

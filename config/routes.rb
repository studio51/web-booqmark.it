Rails.application.routes.draw do

  root controller: :landings, action: :index

  devise_for :users,
    controllers: {
      registrations: 'registrations',
      omniauth_callbacks: 'omniauth_callbacks'
    }

  resources :users

  resources :feed do
    shallow do
      resources :collections, only: :index
      resources :bookmarks, only: :index
    end
  end

  resources :collections do
    member do
      resources :feed, only: :collections
    end
  end

  resources :bookmarks do
    member do
      resources :feed, only: :bookmarks

      get 'regenerate', to: 'bookmarks#regenerate'
    end
  end

  get 'import', to: 'bookmarks#import_bookmarks'

  resources :tags, only: [:index, :show, :edit], controller: :bookmarks, action: :index
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  resources :settings
end

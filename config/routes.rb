Rails.application.routes.draw do

  root controller: :bookmarks, action: :index

  devise_for :users

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

      resources :snapshot, only: [:create, :update]
    end
  end

  resources :tags, only: [:index, :show, :edit], controller: :bookmarks, action: :index

  resources :settings
end

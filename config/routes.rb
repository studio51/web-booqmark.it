Rails.application.routes.draw do

  root controller: :bookmarks, action: :index

  devise_for :users

  resources :users

  resources :collections
  resources :bookmarks
  resources :tags, only: [:show], controller: :bookmarks, action: :index
end

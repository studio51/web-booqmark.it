Rails.application.routes.draw do

  root to: "bookmarks#index"
  devise_for :users

  resources :bookmarks
  resources :collections

  get 'bookmarks/:tag', to: 'bookmarks#index', as: :tag
end

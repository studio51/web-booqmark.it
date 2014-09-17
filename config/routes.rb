Rails.application.routes.draw do

  root controller: :dashboard, action: :index

  devise_for :users

  resources :collections
  resources :bookmarks, shallow: true do
    get :snapshot, controller: :bookmarks, action: :regenerate_snapshot, as: :regenerate
  end
  resources :tags, only: [:index, :show, :edit], controller: :bookmarks, action: :index

  resources :users

  resources :settings
end

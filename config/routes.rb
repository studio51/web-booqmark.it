Rails.application.routes.draw do

  root to: "bookmarks#index"

  resources :bookmarks

  namespace :api, defaults: { format: :json } do
    resources :bookmarks, only: [:index, :create, :update, :destroy]
  end
end

Rails.application.routes.draw do

  root to: "bookmarks#index"

  resources :bookmarks
end

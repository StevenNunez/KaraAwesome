Rails.application.routes.draw do
  devise_for :users
  resources :playlists
  resources :selections, only: :destroy

  root 'search#index'
end

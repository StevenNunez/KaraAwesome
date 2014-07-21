Rails.application.routes.draw do
  resources :playlists
  resources :selections, only: :destroy

  root 'search#index'
end

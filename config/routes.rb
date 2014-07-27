Rails.application.routes.draw do
  get 'reputation/update'

  devise_for :users
  resources :playlists
  resources :selections, only: :destroy
  match '/reputations/:song_id' => 'reputations#update', via: [:put, :patch], as: :reputation

  root 'search#index'
end

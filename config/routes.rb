Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    resources :teams, only: %i(index show)
    resources :exploits
    resources :flags, only: %i(index create)
  end
end

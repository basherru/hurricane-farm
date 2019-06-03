Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    resources :teams, only: %i[index show create update destroy]
    resources :exploits, only: %i[index show create update destroy]
    resources :flags, only: %i[index create]
  end
end

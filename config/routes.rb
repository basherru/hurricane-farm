# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  root "home#index"

  namespace :api do
    resources :teams, only: %i[index show create update destroy]
    resources :exploits, only: %i[index show create update destroy]
    resources :flags, only: %i[index create]
  end

  resources :teams, except: %i[show]
  resources :exploits
  resources :flags, only: %i[index new create]
end

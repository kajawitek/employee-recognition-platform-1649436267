# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :employees
  
  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[index create]

  root 'kudos#index'

  namespace :admins do
    resources :kudos, only: %i[index destroy]
    root 'pages#dashboard'
    resources :employees
    resources :company_values
    resources :rewards

  end
end

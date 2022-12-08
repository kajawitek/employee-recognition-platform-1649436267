# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :employees
  
  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[index new create]

  root 'kudos#index'

  namespace :admins do
    resources :kudos, only: %i[index destroy]
    root 'pages#dashboard'
    resources :employees do
      patch 'add_available_kudos', on: :collection
    end
    resources :company_values
    resources :rewards do
      collection do
        get 'import'
        post 'import'
      end
    end
    resources :orders, only: :index do
      patch 'deliver', on: :member
    end
    resources :categories
    resources :online_codes, only: %i[index new create destroy] do
      collection do
        post 'import'
      end
    end
  end
end

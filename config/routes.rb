# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :employees
  

  resources :kudos

  root 'kudos#index'

  namespace :admins do
    resources :kudos, only: %i[index destroy]
    root 'pages#dashboard'
    resources :employees
    resources :company_values
    resources :rewards
    


  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

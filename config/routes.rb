# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  resources :kudos
  devise_for :employees
  # get 'home/index'
  #root 'home#index'
  root 'kudos#index'

  namespace :admins do
    root 'pages#dashboard'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

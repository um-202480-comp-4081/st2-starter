# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: redirect('yoga_poses')

  get 'yoga_poses', to: 'yoga_poses#index', as: 'yoga_poses'
  get 'yoga_poses/:id', to: 'yoga_poses#show', as: 'yoga_pose'
end

# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    invitations: 'admin/users/invitations'
  }

  # If a user is logged in, send them to the outreach events index
  authenticated :user do
    root 'outreach_events#index', as: :authenticated_root
  end

  # Else, use the home index
  root 'home#index'

  resources :cohorts, only: %i[index show]
  resources :outreach_events

  resources :users
  get "/profile", to: "users#show" 
  get '/profile/edit', to: 'users#edit'

  namespace :admin do
    resources :cohorts, except: %i[index show]
    resources :outreach_events, only: :index
    resources :outreach_event_types, except: [:show]
  end
end

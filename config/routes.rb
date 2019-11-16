Rails.application.routes.draw do
  devise_for :users, controllers: { 
    invitations: "admin/users/invitations"
  }
  root "home#index"

  resources :cohorts, only: [:index, :show]
  resources :outreach_events

  resources :users
  get "/profile", to: "users#show" 
  get "/profile/edit", to: "users#edit" 

  namespace :admin do
    resources :cohorts, except: [:index, :show]
    resources :outreach_events, only: :index
    resources :outreach_event_types, except: [:show]
  end

  namespace :facilitator do
    resources :outreach_events, only: :index
  end
end

Rails.application.routes.draw do
  devise_for :users #, :controllers => { registrations: "registrations", sessions: "sessions", invitations: "invitations", password: "passwords" }
  root "home#index"

  resources :outreach_events

  resources :users
  get "/profile", to: "users#profile" 

  namespace :admin do
    resources :outreach_events, only: :index
  end
end

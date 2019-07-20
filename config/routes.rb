Rails.application.routes.draw do
  devise_for :users #, :controllers => { registrations: "registrations", sessions: "sessions", invitations: "invitations", password: "passwords" }
  root "home#index"

  resources :outreach_events
end

Rails.application.routes.draw do
  get "reservations/index"
  root "pages#home"
  resources :reservations, only: [ :index ]

  get "register", to: "registration#new", as: "registration"
  post "register", to: "registration#create"

  get "login", to: "session#new"       # Display login form
  post "login", to: "session#create"    # Handle login form submission
  delete "logout", to: "session#destroy" # Handle logout
end

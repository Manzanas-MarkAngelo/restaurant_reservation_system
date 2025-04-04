Rails.application.routes.draw do
  root "pages#home"

  get "register", to: "registration#new", as: "registration"
  post "register", to: "registration#create"

  get "login", to: "session#new"       # Display login form
  post "login", to: "session#create"    # Handle login form submission
  delete "logout", to: "session#destroy" # Handle logout
end

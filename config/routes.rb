Rails.application.routes.draw do
  resources :tables
  # Admin login and logout routes
  get "admin/login", to: "admin_sessions#new", as: "admin_login"
  post "admin/login", to: "admin_sessions#create"
  delete "admin/logout", to: "admin_sessions#destroy", as: "admin_logout"

  # Admin dashboard route (fix the controller and action)
  get "admin_dashboard", to: "admin_dashboard#index", as: "admin_dashboard"
  get "admin_dashboard/all_reservations", to: "admin_dashboard#all_reservations", as: "admin_all_reservations"

  get "reservations/index"
  root "pages#home"

  # resources :reservations

  resources :reservations do
    collection do
      post "confirm"
      get "my_reservations"
    end

    member do
      get "form"  # This creates form_reservation_path(:id)
      patch "cancel"
      patch "admin_cancel", to: "reservations#admin_cancel"
      get "edit"
      patch "update"
    end
  end




  get "register", to: "registration#new", as: "registration"
  post "register", to: "registration#create"

  get "login", to: "session#new"       # Display login form
  post "login", to: "session#create"    # Handle login form submission
  delete "logout", to: "session#destroy" # Handle logout

  # config/routes.rb
  get "time_slots", to: "time_slots#index"

  resources :time_slots
  resources :table_assignments

  # Define routes for admin sessions
  resources :admin_sessions, only: [ :new, :create, :destroy ]

  # Custom route for creating a static admin
  post "create_static_admin", to: "admin_sessions#create_static_admin", as: :create_static_admin
  get "user_time_slots", to: "time_slots#user_index"
end

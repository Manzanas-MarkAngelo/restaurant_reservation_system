# app/controllers/session_controller.rb
class SessionController < ApplicationController
  # Show login form
  def new
  end

  # Handle login form submission
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      # Store user ID in the session for authentication
      session[:user_id] = user.id

      redirect_to root_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new  # Render the login form again with an error message
    end
  end

  # Logout the user
  def destroy
    # Clear the session to log the user out
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully."
  end
end

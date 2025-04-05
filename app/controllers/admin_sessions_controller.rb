class AdminSessionsController < ApplicationController
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.find_by(email: params[:admin][:email])

    # Check if the admin exists and authenticate the password
    if @admin.nil?
      flash.now[:alert] = "Admin with this email does not exist."
      render :new and return
    end

    if @admin.authenticate(params[:admin][:password])
      session[:admin_id] = @admin.id # Store the admin's ID in session
      flash[:notice] = "Admin Logged in successfully."
      redirect_to admin_dashboard_path
    else
      flash.now[:alert] = "Invalid password. Please try again."
      render :new
    end
  end

  def destroy
    session.delete(:admin_id) # Delete session to logout
    flash[:notice] = "Admin logged out successfully."
    redirect_to login_path
  end
end

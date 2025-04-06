class AdminSessionsController < ApplicationController
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.find_by(email: params[:admin][:email])

    # Check if the admin exists and authenticate the password
    if @admin.nil? || !@admin.authenticate(params[:admin][:password])
      flash.now[:alert] = "Invalid email or password. Please try again."
      render :new, status: :unprocessable_entity
    else
      session[:admin_id] = @admin.id # Store the admin's ID in session
      flash[:notice] = "Admin Logged in successfully."
      redirect_to admin_dashboard_path
    end
  end

  def destroy
    session.delete(:admin_id) # Delete session to logout
    flash[:notice] = "Admin logged out successfully."
    redirect_to login_path
  end

  # Action to create a static admin
  def create_static_admin
    # Static admin data
    email = "admin123@gmail.com"
    password = "admin123456"
    username = "admin123"

    # Check if an admin with the given email already exists
    unless Admin.exists?(email: email)
      @admin = Admin.new(username: username, email: email, password: password)

      if @admin.save
        flash[:notice] = "Static admin created successfully."
      else
        flash[:alert] = "Failed to create static admin."
      end
    else
      flash[:alert] = "Admin already exists."
    end

    # Redirect back to the login page
    redirect_to admin_login_path
  end
end

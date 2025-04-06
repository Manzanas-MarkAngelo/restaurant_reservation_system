class AdminSessionsController < ApplicationController
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.find_by(email: params[:admin][:email]) || Admin.new(email: params[:admin][:email])

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
end

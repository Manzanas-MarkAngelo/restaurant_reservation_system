class AdminDashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @admin = current_admin
  end

  private

  def authenticate_admin!
    # Redirect to login if there's no admin logged in
    unless current_admin
      flash[:alert] = "Please log in to access the dashboard."
      redirect_to admin_login_path
    end
  end
end

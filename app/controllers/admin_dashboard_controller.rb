class AdminDashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @admin = current_admin
        # Get the start date from the params or use today's date by default
        @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today

        # Calculate previous and next month dates manually
        @previous_month = @start_date.prev_month.beginning_of_month
        @next_month = @start_date.next_month.beginning_of_month
        @unavailable_dates = [ Date.new(2025, 4, 5), Date.new(2025, 4, 12) ] # for example
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

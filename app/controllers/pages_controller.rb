class PagesController < ApplicationController
  def home
    # Get the start date from the params or use today's date by default
    @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today

    # Calculate previous and next month dates manually
    @previous_month = @start_date.prev_month.beginning_of_month
    @next_month = @start_date.next_month.beginning_of_month
  end
end

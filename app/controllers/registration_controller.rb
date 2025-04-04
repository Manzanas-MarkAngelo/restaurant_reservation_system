class RegistrationController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # Check if the email already exists
    if User.exists?(email: @user.email)
      flash.now[:alert] = "This email is already taken. Please choose a different one."
      render :new and return
    end

    if @user.save
      flash[:notice] = "Registration successful! Please log in."
      redirect_to login_path,  notice: "Account created successfully!"
    else
      flash.now[:alert] = "There were some errors with your registration."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :contact_number, :password, :password_confirmation)
  end
end

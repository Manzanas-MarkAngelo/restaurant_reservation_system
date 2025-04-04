class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :contact_number, presence: true, length: { is: 11, message: "must be 11 digits" }, numericality: { only_integer: true, message: "must be a valid number" }
  validates :password, presence: true, length: { minimum: 6, message: "must be at least 6 characters" }
  validates :password_confirmation, presence: true
  validate :passwords_match

  # Custom validation for password and confirmation match
  def passwords_match
    if password != password_confirmation
      errors.add(:password_confirmation, "doesn't match Password")
    end
  end
end

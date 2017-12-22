class User::SignUp < User

  PERMITTED_PARAMS = [
    :email,
    :name,
    :password,
    :password_confirmation,
    :born_at
  ]

  # Courtesy http://emailregex.com/
  EMAIL_REGEXP = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEXP }
  validates_presence_of :name
  validates :password, confirmation: true

  after_create :send_welcome_email

  private

    def send_welcome_email
      # TODO: Mailer.welcome(user).deliver
      Rails.logger.info "Sending Welcome Email"
    end
end

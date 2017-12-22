class Api::Users::SessionsController < Api::ApiController
  class User::NotFound < StandardError; end

  skip_before_action :authenticate
  rescue_from User::NotFound, with: :deny_access

  def create
    @user = User.find_by(email: sign_in_params[:email])

    raise User::NotFound unless @user

    if @user.authenticate(sign_in_params[:password])
      jwt = Auth.issue({user: @user.id, name: @user.name})
      render json: {jwt: jwt}, status: 201
    else
      deny_access
    end
  end

  private
    def sign_in_params
      params.require(:user).permit(User::SignIn::PERMITTED_PARAMS)
    end

    def deny_access
      render json: {error: "Email/password combination not found."}, status: 401
    end
end

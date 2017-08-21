class Api::V1::Users::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate

  def create
    user = User.find_by(email: sign_in_params[:email])
    if user.authenticate(sign_in_params[:password])
      jwt = Auth.issue({user: user.id})
      render json: {jwt: jwt}
    else
    end
  end

  private
    def sign_in_params
      params.require(:user).permit(:email, :password)
    end
end

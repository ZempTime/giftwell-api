class Api::Users::RegistrationsController < Api::ApiController
  skip_before_action :authenticate

  def create
    @user = User::SignUp.new(registration_params)

    if @user.save
      jwt = Auth.issue({user: @user.id, name: @user.name})
      render json: {jwt: jwt}, status: 201
    else
      render json: @user, status: 200, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private
    def registration_params
      params.require(:user).permit(User::SignUp::PERMITTED_PARAMS)
    end
end

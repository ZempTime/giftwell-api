class Api::V1::Users::RegistrationsController < Api::V1::ApiController
  def create
    @user = User::SignUp.new(registration_params)

    if @user.save
      render json: @user, status: 200
    else
      render json: @user, status: 200, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private
    def registration_params
      params.require(:user).permit(User::SignUp::PERMITTED_PARAMS)
    end
end

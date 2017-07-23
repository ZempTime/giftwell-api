class Api::V1::UserTokenController < Knock::AuthTokenController

  def entity_name
    'Physical::User'
  end

end

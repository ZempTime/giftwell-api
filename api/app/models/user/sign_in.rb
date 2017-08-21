class User::SignIn < User
  PERMITTED_PARAMS = [
    :email,
    :password
  ]
end

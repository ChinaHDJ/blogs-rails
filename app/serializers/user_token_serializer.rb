class UserTokenSerializer
  include FastJsonapi::ObjectSerializer

  attributes :success, :message, :token
end

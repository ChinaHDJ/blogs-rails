class UserTokenSerializer
  include FastJsonapi::ObjectSerializer
  set_id :success
  attributes :success, :message, :token
end

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :avatar_url, :username, :email, :is_deleted, :deleted_at
end

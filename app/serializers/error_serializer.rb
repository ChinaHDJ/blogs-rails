class ErrorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :success, :message
end

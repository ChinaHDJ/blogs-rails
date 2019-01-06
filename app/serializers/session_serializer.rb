class SessionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :year
end

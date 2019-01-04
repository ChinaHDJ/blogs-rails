module App
  class UserToken
    SECRET_KEY = ENV["SECRET_KEY"]
    AbstractStruct = Struct.new(:success, :message)

    ExpiredResult = AbstractStruct.new(false, "expire")
    NotBeforeTimerResult = AbstractStruct.new(false, "token invlid")

    class << self
      def auth(token)
        begin
          json = JWT.decode token, SECRET_KEY, true, { algorithm: 'HS256' }

        rescue JWT::ExpiredSignature
          return ExpiredResult
        rescue JWT::JWT::ImmatureSignature
          return NotBeforeTimerResult
        end
      end

      def create(email, password)
        user = User.find_by(email: email)

        if !user.nil? &&  user.authenticate(password)
          access_token = Session.create_access_token(user.id)

          return new AbstractStruct.new(false, "access_token") if access_token.nil?

          payload = {
              user_id: user.id,
              access_token: access_token,
              exp: (Time.new + 30.day).to_i,
              nbf: Time.now
          }

          AbstractStruct.new(true, JWT.encode(payload, SECRET_KEY, 'HS256'))
        end

      end
    end
  end
end

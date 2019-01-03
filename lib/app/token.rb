module App
  class UserToken
    SECRET_KEY = ENV["SECRET_KEY"]
    AbstractStruct = Struct.new(:success, :message)

    ExpiredResult = AbstractStruct.new(false, "用户会话已过期，请重新登入")
    NotBeforeTimerResult = AbstractStruct.new(false, "token 无法验证")

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

      def create(token)
        raise if token.blank?

        JWT.decode token, SECRET_KEY, true, { algorithm: 'HS256' }
      end
    end
  end
end

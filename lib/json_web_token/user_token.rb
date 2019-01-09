module JsonWebToken
  class UserToken
    SECRET_KEY = ENV["SECRET_KEY"]
    TokenStruct = Struct.new(:success, :message, :token)

    class << self
      def auth(token)
        result = decode(token)

        return result if result.is_a?(TokenStruct)

        payload = result[0]
        user_id = payload['user_id']
        access_token = payload['access_token']

        session = Session.find_by(user_id: user_id)

        raise ActiveRecord::RecordNotFound if session.nil?

        session.access_token === access_token
      end

      def decode(token)
        JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        TokenStruct.new(false, '这是一个无效的token', nil)
      rescue JWT::ExpiredSignature
        TokenStruct.new(false, 'token已过期', nil)
      rescue JWT::ImmatureSignature
        TokenStruct.new(false, 'token数据异常', nil)
      end

      def create(hash)
        email = hash[:email]
        password = hash[:password]
        puts email,password
        user = User.find_by(email: email)

        if !user.nil? &&  user.authenticate(password)
          access_token = Session.create_access_token(user.id)

          return TokenStruct.new(false, 'access_token', nil) if access_token.nil?

          payload = {
              user_id: user.id,
              access_token: access_token,
              exp: (Time.new + 30.day).to_i,
              nbf: Time.now
          }

          TokenStruct.new(true, '登入成功', JWT.encode(payload, SECRET_KEY, 'HS256'))
        end
      end

      def destroy(token)
        result = decode(token)

        return result if result.is_a?(TokenStruct)

        user_id = result[0]['user_id']

        Session.clear_access_token(user_id)
      end
    end
  end
end

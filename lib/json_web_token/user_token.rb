module JsonWebToken
  class UserToken
    SECRET_KEY = ENV["SECRET_KEY"]
    TokenStruct = Struct.new(:success, :message, :token)

    class << self
      def decode(token)
        @decode ||= JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
      end

      def auth_user(token)
        result = decode(token)

        User.find(result[0]['user_id'])
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
        else
          TokenStruct.new(false, '邮箱或密码错误', nil)
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

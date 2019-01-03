module App
  class AppToken
    SECRET_KEY = ENV["SECRET_KEY"]

    class << self

      def encode(payload)
        raise if payload.blank?

        JWT.encode payload, SECRET_KEY, 'HS256'
      end

      def decode(token)
        raise if token.blank?

        JWT.decode token, SECRET_KEY, true, { algorithm: 'HS256' }
      end
    end
  end
end

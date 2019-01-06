class Session < ApplicationRecord

  def self.create_access_token(user_id)
    access_token = SecureRandom.hex(16)
    session = Session.find_or_create_by(user_id: user_id)

    return access_token if session.update(access_token: access_token, expire_at: Time.now + 30.day)
  end

  def self.clear_access_token(user_id)
    session = Session.find_by(user_id: user_id)
    return false unless session

    session.access_token = nil
    session.save
  end
end

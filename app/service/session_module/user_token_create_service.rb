class SessionModule::UserTokenCreateService < BaseService
  delegate :email, :password, to: :params_object

  validate do
    puts 123
    execute_validation :validate_user
  end

  def execute
    puts @params[:email], email
    #JsonWebToken::UserToken.create(@session).to_h
    {}
  end

  def validate_user
    puts 'user'
  end
end

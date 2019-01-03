class ApplicationController < ActionController::API

  def auth_token
    result = App::UserToken.auth(token_record)
    render json: { success: false, message: result.message } unless result.success
  end

  private

  def token_record
    params[:token]
  end

end

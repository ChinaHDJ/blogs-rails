class ApplicationController < ActionController::API

  def auth_token
    result = App::UserToken.auth(token_record)
    render json: { success: false, message: result.message } unless result.success
  end

  private

  def token_record
    params[:token]
  end

  def render_success(message, attributes = {})
    render json: { success: true, message: message }.merge(attributes: attributes)
  end

  def render_error(message, attributes = {})
    render json: { success: false, message: message }.merge(attributes: attributes)
  end
end

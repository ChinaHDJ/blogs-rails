class Api::V1::ApplicationController < ActionController::API
  before_action :authenticate

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def authenticate
    @token = params.dig(:session, :token)

    return render_error_message('token值不能为空') if token.blank?
    result = JsonWebToken::UserToken.auth(token)
    return render json: result if result.is_a?(Struct)
    render_error_message('token有误。可能已经过期了') unless result
  end

  def curr_user
    @curr_user ||= JsonWebToken::UserToken.auth_user(@token)
  end

  def record_not_found
    render404('record_not_found', '资源404')
  end

  def render404(type, message)
    render json: {
        type: type,
        success: false,
        message: message
    }
  end

  def render_error_message(message)
    render json: {
        success: false,
        message: message
    }
  end

  def render_success_message(message)
    render json: {
        success: true,
        message: message
    }
  end

  def handle_params
    begin
      send("param_record_#{params[:action]}")
    rescue
      render_error_message('参数有误')
    end
  end

end

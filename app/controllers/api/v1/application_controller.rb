class Api::V1::ApplicationController < ActionController::API
  include SetCurrentConcern
  include AuthTokenConcern

  before_action :authenticate!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def curr_user
    Current.user
  end

  def record_not_found
    render404('record_not_found', '资源404')
  end

  def render404(type, message)
    render json: {
        type: type,
        success: false,
        message: message
    }, status: 404
  end

  def render_error_message(message, status)
    render json: {
        success: false,
        message: message
    }, status: status
  end

  def render_success_message(message)
    render json: {
        success: true,
        message: message
    }
  end

  def render_serializers(serializers, status = 200)
    render json: serializers, status: status
  end

  def handle_params
    begin
      send("param_record_#{params[:action]}")
    rescue
      render_error_message('参数有误', 403)
    end
  end

end

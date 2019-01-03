class Api::V1::Application < ActionController::API
  before_action :authenticate!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def authenticate!
    josn = App.Token.decode(params[:access_token])

    session = Session.find(json['session_id'])

    if session.access_token != params[:access_token]
    end
  end

  def record_not_found
    render404('record_not_found', '请求资源不存在')
  end

  def render404(type, message)
    render json: {
      type: type,
        success: false,
        message: message
    }
  end
end

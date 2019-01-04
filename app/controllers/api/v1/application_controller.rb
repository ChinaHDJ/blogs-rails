class Api::V1::ApplicationController < ActionController::API
  #before_action :authenticate!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def authenticate!
    josn = App::UserToken.decode(params[:access_token])

    session = Session.find(json['session_id'])

    if session.access_token != params[:access_token]
    end
  end

  def record_not_found
    render404('record_not_found', '404')
  end

  def render404(type, message)
    render json: {
      type: type,
        success: false,
        message: message
    }
  end
end

module AuthTokenConcern
  extend ActiveSupport::Concern

  private

  def authenticate!
    return render_error_message('token不存在', 401) unless params[:token]

    result = JsonWebToken::UserToken.decode(params[:token])

    return render_error_message('当前用户不存在', 401) unless User.find_by(id: result['user_id'])
    set_current(result)
  rescue
    render_error_message('token有误', 401)
  end
end

class Api::V1::SessionsController < Api::V1::ApplicationController
  skip_before_action :authenticate!, only: :create

  before_action :handle_params

  def create
    render json: JsonWebToken::UserToken.create(@param_session).to_h
  end

  def destroy
    if JsonWebToken::UserToken.destroy(@param_session[:token])
      render_success_message('用户注销成功')
    else
      render_error_message('用户注销失败', 401)
    end
  end

  def param_record_create
    @param_session = params.require(:session).permit(:email, :password, :captcha)
    raise if @param_session[:email].blank? || @param_session[:password].blank?
  end

  def param_record_destroy
    @param_session = params.require(:session).permit(:token)
    raise unless @param_session[:token]
  end

end
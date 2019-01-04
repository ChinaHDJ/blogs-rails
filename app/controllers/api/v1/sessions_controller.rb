class Api::V1::SessionsController < Api::V1::ApplicationController

  def create
    render json: App::UserToken.create(param_session[:email], param_session[:password]).to_h
  end

  private

  def param_session
    params.require(:session).permit(:email, :password, :captcha)
  end
end
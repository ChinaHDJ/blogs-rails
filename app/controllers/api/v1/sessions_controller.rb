class Api::V1::SessionsController < Api::V1::ApplicationController

  def create

  end

  private

  def param_session
    params.require(:session).premit(:email, :password, :captcha)
  end
end
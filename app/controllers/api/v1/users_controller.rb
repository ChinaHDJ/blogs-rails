class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index; end

  def show
    render_serializers UserSerializer.new(@user)
  end

  def update; end

  def destroy; end

  private

  def set_user
    @user = User.find_by(username: params[:id])
  end
end

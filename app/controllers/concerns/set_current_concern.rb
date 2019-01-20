module SetCurrentConcern
  extend ActiveSupport::Concern

  private

  def set_current(data)
    Current.user = User.find(data['user_id'])
  end
end
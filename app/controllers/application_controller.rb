class ApplicationController < ActionController::Base
  protect_from_forgery
  around_filter :set_time_zone

  private

  def set_time_zone
    old_time_zone = Time.zone
    Time.zone = current_user.timezone if user_signed_in?
    yield
  ensure
    Time.zone = old_time_zone
  end

end

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def after_sign_in_path_for(resource)
    # new user who hasn't edited their profile info
    if current_user.profile.nil? && ((Date.today - 7.days)..Date.today).include?(current_user.created_at.to_date)
      user_path(current_user)
    else
      posts_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

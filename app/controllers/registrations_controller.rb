class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    users_show_path
  end
end
class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
     users_show_path
  end

  def after_sign_in_path_for(resource)
    users_show_path
  end

  # def create
  #   binding.pry
  # end
end
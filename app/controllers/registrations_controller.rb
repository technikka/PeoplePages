class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for (resource)
     user_path
  end

  # def create
  #   binding.pry
  # end
end
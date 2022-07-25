class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save && current_user.update({ name: user_params[:user][:name] })
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
    @profile = Profile.find_by(user_id: params[:user_id])
  end

  def update
    @user = current_user
    @profile = Profile.find_by(user_id: params[:user_id])

    if @profile.update(edited_profile_params) && @user.update({ name: edited_profile_params[:user_attributes][:name] })

      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.permit(:current_city, :hometown, :workplace, :websites, :social_links, :image)
  end

  def user_params
    params.permit(:id, user: [:name])
  end

  def edited_profile_params
    params.require(:profile).permit(:current_city, :hometown, :workplace, :websites, :social_links, :image, user_attributes: [:name, :id])
  end
end

class ProfilesController < ApplicationController
  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      redirect_to user_path(current_user), notice: 'Profile information saved'
    else
      render :new, status: :unprocessable_entity, alert: 'Problem saving profile information'
    end
  end

  def edit
    @user = current_user
    @profile = Profile.find_by(user_id: params[:user_id])
  end

  def update
    @user = current_user
    @profile = Profile.find_by(user_id: params[:user_id])

    if @profile.update(profile_params)
      redirect_to user_path(current_user), notice: 'Profile information updated'
    else
      render :new, status: :unprocessable_entity, alert: 'Problem updating profile information'
    end
  end

  private

  def profile_params
    params.permit(:name, :current_city, :hometown, :workplace, :websites, :social_links)
  end
end

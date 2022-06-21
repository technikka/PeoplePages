class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update

  end

  private

  def profile_params
    params.require(:profile).permit(:name, :current_city, :hometown, :workplace, :websites, :social_links)
  end
end

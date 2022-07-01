class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.includes(:profile)
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    if params[:query].include?('@')
      @queried_user = User.find_by(email: params[:query])
    else
      profile = Profile.find_by(name: params[:query])
      @queried_user = profile.user if profile
    end

    render partial: 'search'
  end
end

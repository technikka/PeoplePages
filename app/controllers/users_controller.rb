class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    # ATTENTION: not sure about this statement
    @user = current_user || User.find(params[:id])
  end
end

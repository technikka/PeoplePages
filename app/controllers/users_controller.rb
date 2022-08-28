class UsersController < ApplicationController
  def index
    @users = User.includes(profile: [image_attachment: [:blob]]).all
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    search = params[:query].downcase
    @query_results = User.where('lower(name) LIKE ?', "%" + User.sanitize_sql_like(search) + "%").or(User.where(email: params[:query]))

    render partial: 'search'
  end
end

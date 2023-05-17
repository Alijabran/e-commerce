class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destory]
  def index
    @users = User.search(params[:search])
  end

  def show; end

  def edit; end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted.'
  end
end

private

def set_user
  @user = User.find(params[:id])
end

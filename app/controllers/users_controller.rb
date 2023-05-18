class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]

  def index
    @pagy, @users = pagy(User.search(params[:search]))
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      redirect_to edit_user_path, notice: 'User not updated'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'User was successfully deleted.'
  end

  def export
    @users = User.all

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

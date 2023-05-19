class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_admin, only: %i[edit show destroy]

  def index
    @sort_column = params[:sort_column] || 'email' || 'first_name'
    @sort_direction = params[:sort_direction] || 'asc'
    @pagy, @users = pagy(User.search(params[:search]).order("#{@sort_column} #{@sort_direction}"))
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
    if @user.destroy
      redirect_to root_path, notice: 'User was successfully deleted.'
      else
        redirect_to root_path, notice: 'User not deleted'
    end
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

  def require_admin
    return if @user == current_user || current_user.admin?

    redirect_to root_path, alert: 'You are not authorized to perform this action.'
  end
end

class InvitationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation!
    if @user.save
      InvitationsMailer.invite_user_email(user_params[:email], user_params[:password]).deliver_later
      redirect_to root_path, alert: 'Invitation sent'
    else
      redirect_to new_invitation_path, alert: 'Invitation not sent'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end

class InvitationsMailer < ApplicationMailer
  def invite_user_email(email, password)
    @email = email
    @password = password
    mail(
      to: @email,
      subject: "User Invitation",
      body: "Your email is #{email} and password is #{password}"
    )
  end
end
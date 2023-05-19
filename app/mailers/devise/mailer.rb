class Devise::Mailer < Devise.parent_mailer.constantize
    # def invitation_instructions(record, token, opts = {})
    #   @temporary_password = record.password # Assuming the temporary password is stored in the `password` attribute
    #   devise_mail(record, :invitation_instructions, opts)
    # end
  end
  
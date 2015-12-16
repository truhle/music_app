class ActivationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.activation_mailer.account_activation.subject
  #
  def account_activation(user)
    @activation_token = user.activation_token

    mail to: user.email,
         subject: "Activate your Music App account"
  end
end

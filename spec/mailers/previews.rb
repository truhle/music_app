# Preview all emails at http://localhost:3000/rails/mailers/activation_mailer

class ActivationMailerPreview < ActionMailer::Preview

  def account_activation
    user = User.first
    ActivationMailer.account_activation(user)
  end
end


class User < ActiveRecord::Base

  before_validation :ensure_session_token!
  before_save :downcase_email

  validates :email, :password_digest, :session_token, :activation_token, presence: true
  validates :email, :session_token, :activation_token, uniqueness: true
  validates_confirmation_of :password

  has_secure_password
  has_many :notes, dependent: :destroy


  def ensure_session_token!
    session_token || reset_session_token!
  end

  def reset_session_token!
    self.update_attributes(session_token: User.generate_token)
  end

  def self.find_by_credentials(email, password)
    User.find_by(email: email).try(:authenticate, password)
  end

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  def set_activation_token
    self.activation_token = User.generate_token
  end

private

  def downcase_email
    self.email = email.downcase
  end

end

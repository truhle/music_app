
class User < ActiveRecord::Base

  after_initialize :ensure_session_token!

  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true

  has_secure_password
  has_many :notes, dependent: :destroy

  def self.find_by_credentials(email, password)
    User.find_by(email: email).try(:authenticate, password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.update_attributes(session_token: User.generate_session_token)
  end

  def ensure_session_token!
    session_token || reset_session_token!
  end


end

class User < ActiveRecord::Base
  has_secure_password

  attr_accessor :email
  attr_accessor :auth_token
  attr_accessor :password
  attr_accessor :password_reset_token

  validates :email, uniqueness: true

  before_create { generate_token(:auth_token) }

  def send_password_reset
    logger.debug "User: #{self.attributes.inspect}"
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end

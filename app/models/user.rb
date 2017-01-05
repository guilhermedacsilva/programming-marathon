class User < ActiveRecord::Base
  attr_accessor :remember_token

  before_save { name.downcase! }

  validates :name,
            presence: true,
            length: { minimum: 3, maximum: 255 },
            uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  def self.digest(text)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(text, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end

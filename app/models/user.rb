class User < ActiveRecord::Base
  acts_as_paranoid
  validates_as_paranoid
  validates_uniqueness_of_without_deleted :name
  attr_accessor :remember_token
  attr_accessor :new_password, :new_password_confirmation
  before_save :fix_name
  before_validation :fix_name
  validates :name,
            presence: true,
            length: { minimum: 3, maximum: 255 }
  validates :password, length: { minimum: 6 }, if: :password_changed?
  has_secure_password
  belongs_to :marathon

  ACCESS_ADMIN = 1

  def admin?
    access == ACCESS_ADMIN
  end

  def access_type
    admin? ? 'Administrator' : 'Team'
  end

  def password_changed?
    !new_password.blank? || password_digest.blank?
  end

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

  private

  def fix_name
    name.strip!
    name.downcase!
  end
end

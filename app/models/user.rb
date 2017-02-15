class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  acts_as_paranoid
  validates_as_paranoid
  validates_uniqueness_of_without_deleted :name
  validates :name,
            presence: true,
            length: { minimum: 3, maximum: 255 }
  belongs_to :marathon

  ACCESS_ADMIN = 1

  def admin?
    access == ACCESS_ADMIN
  end

  def access_type
    admin? ? 'Administrator' : 'Team'
  end

  # Skip email verification on login or signup
  def email_required?
    false
  end

  def email_changed?
    false
  end
end

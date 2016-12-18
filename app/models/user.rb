class User < ActiveRecord::Base
  before_save { name.downcase! }

  validates :name,
            presence: true,
            length: { minimum: 3, maximum: 255 },
            uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password
end

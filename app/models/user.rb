class User < ActiveRecord::Base
  validates :name,
            presence: true,
            length: { minimum: 3, maximum: 255 },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { maximum: 255 }
end

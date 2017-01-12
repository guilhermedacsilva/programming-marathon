class Marathon < ActiveRecord::Base
  acts_as_paranoid
  has_many :users
  validates :name, presence: true, length: { minimum: 3, maximum: 255 }

  before_save do
    name.strip!
  end

  def self.all_can_register
    where(can_register: true).order(:name)
  end
end

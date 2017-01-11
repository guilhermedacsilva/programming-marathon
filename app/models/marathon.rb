class Marathon < ActiveRecord::Base
  acts_as_paranoid

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }

  before_save do
    name.strip!
  end
end

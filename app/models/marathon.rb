class Marathon < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3, maximum: 255 }

  scope :all_openned, -> { where(open: true).order(:name) }

  before_save do
    name.strip!
  end
end

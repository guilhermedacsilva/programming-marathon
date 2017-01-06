class Marathon < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3, maximum: 255 }
  validates :open, presence: true

  scope :all_openned, -> { where(open: true).order(:name) }
end

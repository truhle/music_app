class Track < ActiveRecord::Base
  belongs_to :album
  has_many :notes, dependent: :destroy

  validates :name, :track_type, presence: true

end

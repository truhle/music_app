class Track < ActiveRecord::Base
  belongs_to :album

  validates :name, :track_type, presence: true

end

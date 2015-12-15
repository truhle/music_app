class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks, dependent: :destroy

  validates :name, :album_type, presence: true

  def same_band_albums
    band.albums.sort
  end
end

class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks, dependent: :destroy
end

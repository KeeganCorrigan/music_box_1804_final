class Genre < ApplicationRecord
  validates_presence_of :name
  has_many :song_genres

  has_many :songs, through: :song_genres

  def average_rating
    songs.average(:rating)
  end
end

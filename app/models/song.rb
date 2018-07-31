class Song < ApplicationRecord
  validates_presence_of :title, :length, :play_count
  belongs_to :artist
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs

  has_many :song_genres
  has_many :genres, through: :song_genres

  before_save :generate_slug


  def to_param
    slug
  end

  def generate_slug
    self.slug = title.parameterize
  end

  def self.similar_ratings(rating, name)
    where(rating: rating).reject { |song| song.title == name }
  end
end

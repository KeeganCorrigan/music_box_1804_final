require "rails_helper"

describe Genre, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  describe "relationships" do
    it { should have_many(:songs).through(:song_genres)}
  end

  describe "instance methods" do
    it ".average_rating should return average rating for all songs in genre" do
      artist = Artist.create(name: 'Bieber')

      song_1 = artist.songs.create(title: 'this is the song that never ends...', length: 100, play_count: 15, rating: 4)
      song_2 = artist.songs.create(title: 'this ispoaksdpokopasd', length: 200, play_count: 20, rating: 2)

      genre_1 = Genre.create!(name: "oijoiajsd")

      SongGenre.create!(genre: genre_1, song: song_1)
      SongGenre.create!(genre: genre_1, song: song_2)

      expected = 3

      expect(genre_1.average_rating).to eq(expected)
    end

    it ".ratings returns a sorted list of rated songs in that genre" do
      artist = Artist.create(name: 'Bieber')

      song_1 = artist.songs.create(title: 'this is the song that never ends...', length: 100, play_count: 15, rating: 4)
      song_2 = artist.songs.create(title: 'this ispoaksdpokopasd', length: 200, play_count: 20, rating: 2)

      genre_1 = Genre.create!(name: "oijoiajsd")

      SongGenre.create!(genre: genre_1, song: song_1)
      SongGenre.create!(genre: genre_1, song: song_2)

      expected = [song_1, song_2]

      expect(genre_1.ratings).to eq(expected)
    end
  end
end

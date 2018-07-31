require 'rails_helper'

describe Song, type: :model do
  describe 'validations' do
    it{should validate_presence_of(:title)}
    it{should validate_presence_of(:length)}
    it{should validate_presence_of(:play_count)}
  end

  describe 'relationships' do
    it{should belong_to(:artist)}
    it{should have_many(:genres).through(:song_genres)}
  end

  describe "class methods" do
    it ".similar_ratings can group songs with similar ratings" do
      artist = Artist.create(name: 'Bieber')

      song_1 = artist.songs.create(title: 'this is the song that never ends...', length: 100, play_count: 15, rating: 4)
      song_2 = artist.songs.create(title: 'this ispoaksdpokopasd', length: 200, play_count: 20, rating: 2)
      song_3 = artist.songs.create(title: 'ioajsdoi', length: 200, play_count: 20, rating: 2)
      song_4 = artist.songs.create(title: 'iojasdjoijsd', length: 200, play_count: 20, rating: 2)

      expected = [song_3, song_4]

      expect(Song.similar_ratings(song_2.rating, song_2.title)).to eq(expected)
    end
  end
end

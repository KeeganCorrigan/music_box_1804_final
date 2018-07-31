require 'rails_helper'

describe 'visits song show' do
  context "a visitor" do
    it 'sees genres associated with song' do
      artist = Artist.create(name: 'Bieber')

      song_1 = artist.songs.create(title: 'this is the song that never ends...', length: 100, play_count: 15)

      genre_1 = Genre.create!(name: "oijoiajsd")
      genre_2 = Genre.create!(name: "09asd099-ad")
      genre_3 = Genre.create!(name: "-0akc-0k-0as")


      SongGenre.create!(genre: genre_1, song: song_1)
      SongGenre.create!(genre: genre_2, song: song_1)

      visit song_path(song_1)

      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)
      expect(page).to_not have_content(genre_3.name)
    end

    it "sees songs with a similar rating" do
      artist = Artist.create(name: 'Bieber')

      song_1 = artist.songs.create(title: 'this is the song that never ends...', length: 100, play_count: 15, rating: 3)
      song_2 = artist.songs.create(title: '98asd90j0asd', length: 100, play_count: 15, rating: 3)
      song_3 = artist.songs.create(title: '09jad09j09ajsd', length: 100, play_count: 15, rating: 3)
      song_4 = artist.songs.create(title: '-0a90dj09js0a9dj', length: 100, play_count: 15, rating: 3)
      song_5 = artist.songs.create(title: 'oamcoimopsac', length: 100, play_count: 15, rating: 5)

      visit song_path(song_1)

      expect(page).to have_content(song_1.title)
      expect(page).to have_content(song_2.title)
      expect(page).to have_content(song_3.title)
      expect(page).to have_content(song_4.title)
      expect(page).to_not have_content(song_5.title)
    end
  end
end

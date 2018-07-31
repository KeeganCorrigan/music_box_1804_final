require 'rails_helper'

describe 'visits genre show' do
  context "a visitor" do
    it 'sees songs associated with genre' do
      artist = Artist.create(name: 'Bieber')

      song_1 = artist.songs.create(title: 'this is the song that never ends...', length: 100, play_count: 15)
      song_2 = artist.songs.create(title: 'this ispoaksdpokopasd', length: 200, play_count: 20)
      song_3 = artist.songs.create(title: 'toijasd90j0ajsd', length: 300, play_count: 25)

      genre_1 = Genre.create!(name: "oijoiajsd")

      SongGenre.create!(genre: genre_1, song: song_1)
      SongGenre.create!(genre: genre_1, song: song_2)

      visit genre_path(genre_1)

      expect(page).to have_content(song_1.title)
      expect(page).to have_content(song_2.title)
      expect(page).to_not have_content(song_3.title)
    end

    it 'sees average rating for all songs in this genre' do
      artist = Artist.create(name: 'Bieber')

      song_1 = artist.songs.create(title: 'this is the song that never ends...', length: 100, play_count: 15, rating: 4)
      song_2 = artist.songs.create(title: 'this ispoaksdpokopasd', length: 200, play_count: 20, rating: 2)

      genre_1 = Genre.create!(name: "oijoiajsd")

      SongGenre.create!(genre: genre_1, song: song_1)
      SongGenre.create!(genre: genre_1, song: song_2)

      expected = genre_1.average_rating

      visit genre_path(genre_1)

      expect(page).to have_content("Average rating: #{expected}")
    end

    it 'sees name and rating for song with highest rating' do
      artist = Artist.create(name: 'Bieber')

      song_1 = artist.songs.create(title: 'this is the song that never ends...', length: 100, play_count: 15, rating: 4)
      song_2 = artist.songs.create(title: 'this ispoaksdpokopasd', length: 200, play_count: 20, rating: 2)
      song_3 = artist.songs.create(title: 'this ispoaksdpokopasd', length: 200, play_count: 20, rating: 5)

      genre_1 = Genre.create!(name: "oijoiajsd")

      SongGenre.create!(genre: genre_1, song: song_1)
      SongGenre.create!(genre: genre_1, song: song_2)

      visit genre_path(genre_1)

      expect(page).to have_content("Highest score: #{song_1.rating}")
      expect(page).to have_content("Best song: #{song_1.title}")
      expect(page).to have_content("Lowest score: #{song_2.rating}")
      expect(page).to have_content("Worst song: #{song_2.title}")
    end
  end
end

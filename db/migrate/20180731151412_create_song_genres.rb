class CreateSongGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :song_genres do |t|
      t.references :song, foreign_key: true
      t.references :genre, foreign_key: true
    end
  end
end

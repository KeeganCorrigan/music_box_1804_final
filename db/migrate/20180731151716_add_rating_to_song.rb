class AddRatingToSong < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :rating, :integer, default: 0
  end
end

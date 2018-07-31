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
end

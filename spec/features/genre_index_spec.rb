require 'rails_helper'

describe 'visits genre index' do
  context "a visitor" do
    it 'sees two or more genres' do
      genre_1 = Genre.create!(name: "oijoiajsd")
      genre_2 = Genre.create!(name: "o09ja09sdj")

      visit genres_path

      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)
      expect(page).to_not have_content("Create genre")
    end

    it "can click on a genre to visit genre show" do
      genre_1 = Genre.create!(name: "oijoiajsd")
      genre_2 = Genre.create!(name: "o09ja09sdj")

      visit genres_path

      click_on genre_1.name

      expect(current_path).to eq(genre_path(genre_1))
      expect(page).to have_content(genre_1.name)
    end

    it "can not access genre create or new pages" do
      genre_1 = Genre.create!(name: "oijoiajsd")
      genre_2 = Genre.create!(name: "o09ja09sdj")

      visit genres_path

      expect(page).to_not have_content("Create Genre")
    end
  end

  context "it is an admin" do
    it "can create a new genre in genre index page" do
      genre_1 = Genre.create!(name: "oijoiajsd")
      genre_2 = Genre.create!(name: "o09ja09sdj")
      admin = User.create(username: "Dee", password: 'password', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit genres_path

      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)

      name = "990jasdjoi"

      fill_in :genre_name, with: name

      click_on "Create Genre"

      expect(current_path).to eq(genres_path)

      expect(current_path).to eq(genres_path)
      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)
      expect(page).to have_content(name)
      expect(Genre.count).to eq(3)
    end

    it "can not create a genre with incomplete information" do
      admin = User.create(username: "Dee", password: 'password', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit genres_path

      fill_in :genre_name, with: ""

      click_on "Create Genre"

      expect(current_path).to eq(genres_path)

      expect(current_path).to eq(genres_path)
      expect(Genre.count).to eq(0)
    end
  end
end

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

      visit new_admin_genre_path

      expect(page).to_not have_content("Create Genre")
      expect(page).to have_content("404")
    end
  end

  context "it is an admin" do
    it "can create a new genre" do
      genre_1 = Genre.create!(name: "oijoiajsd")
      genre_2 = Genre.create!(name: "o09ja09sdj")
      admin = User.create(username: "Dee", password: 'password', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit genres_path

      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)

      click_on "Create genre"

      expect(current_path).to eq(new_admin_genre_path)
    end

    it "can fill out a form to create a new genre" do
      genre_1 = Genre.create!(name: "oijoiajsd")
      genre_2 = Genre.create!(name: "o09ja09sdj")
      admin = User.create(username: "Dee", password: 'password', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_genre_path

      name = "990jasdjoi"

      fill_in :genre_name, with: name

      click_on "Create Genre"

      expect(current_path).to eq(genres_path)
      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)
      expect(page).to have_content(name)
    end
  end
end

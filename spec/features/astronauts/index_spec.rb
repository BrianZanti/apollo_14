require 'rails_helper'

RSpec.describe "as a visitor" do
  describe "when I visit the astronauts index" do
    it "then I see all astronauts info" do
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      buzz = Astronaut.create!(name: "Buzz Aldrin", age: 38, job: "Engineer")
      jeff = Astronaut.create!(name: "Jeff C.", age: 39, job: "Custodian")

      visit astronauts_path

      within "#astronaut-#{neil.id}" do
        expect(page).to have_content(neil.name)
        expect(page).to have_content("Age: #{neil.age}")
        expect(page).to have_content("Job: #{neil.job}")
      end

      within "#astronaut-#{buzz.id}" do
        expect(page).to have_content(buzz.name)
        expect(page).to have_content("Age: #{buzz.age}")
        expect(page).to have_content("Job: #{buzz.job}")
      end

      within "#astronaut-#{jeff.id}" do
        expect(page).to have_content(jeff.name)
        expect(page).to have_content("Age: #{jeff.age}")
        expect(page).to have_content("Job: #{jeff.job}")
      end
    end

    it "then I see average astronaut age" do
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      buzz = Astronaut.create!(name: "Buzz Aldrin", age: 38, job: "Engineer")
      jeff = Astronaut.create!(name: "Jeff C.", age: 39, job: "Custodian")

      visit astronauts_path

      expect(page).to have_content("Average Age: #{Astronaut.average_age}")
    end

    it "then I see missions for each astronaut in alphabetical order" do
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      buzz = Astronaut.create!(name: "Buzz Aldrin", age: 38, job: "Engineer")
      jeff = Astronaut.create!(name: "Jeff C.", age: 39, job: "Custodian")

      apollo_13 = Mission.create!(title: "Apollo 13", time_in_space: 13)
      gemini_7 = Mission.create!(title: "Gemini 7", time_in_space: 7)
      capricorn_4 = Mission.create!(title: "Capricorn 4", time_in_space: 4)

      neil.missions << [apollo_13, gemini_7, capricorn_4]
      buzz.missions << [apollo_13, gemini_7]
      jeff.missions << [apollo_13]

      visit astronauts_path

      within "#astronaut-#{neil.id}" do
        expect(page.all("li")[0]).to have_content(apollo_13.title)
        expect(page.all("li")[1]).to have_content(capricorn_4.title)
        expect(page.all("li")[2]).to have_content(gemini_7.title)
      end

      within "#astronaut-#{buzz.id}" do
        expect(page.all("li")[0]).to have_content(apollo_13.title)
        expect(page.all("li")[1]).to have_content(gemini_7.title)
      end

      within "#astronaut-#{jeff.id}" do
        expect(page.all("li")[0]).to have_content(apollo_13.title)
      end
    end
  end
end

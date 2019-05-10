require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe "Class Methods" do
    it ".average_age" do
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      buzz = Astronaut.create!(name: "Buzz Aldrin", age: 38, job: "Engineer")
      jeff = Astronaut.create!(name: "Jeff C.", age: 40, job: "Custodian")

      # average = (37 + 38 + 40)/3.0
      expect(Astronaut.average_age.round(2)).to eq(38.33)
    end
  end
end

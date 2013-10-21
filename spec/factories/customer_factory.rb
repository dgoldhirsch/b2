FactoryGirl.define do
  factory :customer do
    name { Faker::Company.name }
    user
  end

end
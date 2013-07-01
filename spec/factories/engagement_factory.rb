FactoryGirl.define do

  factory :engagement do
    start_date { Date.civil(2012, 1, 1) }
    association :customer
  end

end
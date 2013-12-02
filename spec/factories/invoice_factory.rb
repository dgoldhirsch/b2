FactoryGirl.define do
  factory :invoice do
    name { Faker::PhoneNumber.phone_number }
    customer { FactoryGirl.create(:customer) }
    issue_date { Date.civil(2013, 2, 1) }
    service_date { Date.civil(2013, 1, 1) }
    total_charge { 10000 } # 100.00
  end

end

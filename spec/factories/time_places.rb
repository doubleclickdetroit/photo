# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :time_place do
    entity nil
    start "2012-03-05 21:30:03"
    finish "2012-03-05 21:30:03"
    address1 "Rails Programmer AMA"
    address2 "123 Main St."
    address3 "Derpville, OH 45678"
  end
end

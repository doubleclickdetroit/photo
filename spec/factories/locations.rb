# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    entity nil
    line1 "123 Main St."
    line2 "Derpville, OH 45678"
  end
end

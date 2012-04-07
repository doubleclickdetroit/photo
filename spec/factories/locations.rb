# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    address1 "MyString"
    address2 "MyString"
    address3 "MyString"
    entity nil
  end
end

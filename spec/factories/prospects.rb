# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prospect do
    first "MyString"
    last "MyString"
    state "MyString"
    email "MyString"
    heard_from "MyString"
  end
end

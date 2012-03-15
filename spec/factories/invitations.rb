# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    first "MyString"
    last "MyString"
    email "MyString"
    group_id 1
    inviter_id 1
    message "MyText"
  end
end

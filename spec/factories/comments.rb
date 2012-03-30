# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    entity nil
    user nil
    text "MyText"
  end
end

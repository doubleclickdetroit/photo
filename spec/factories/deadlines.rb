# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deadline do
    entity nil
    due "2012-03-03 17:28:35"
    met false
  end
end

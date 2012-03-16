# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :form_data do
    sequence(:data) do |n|
      {'number' => n, 'from' => 'spec/factories/form_data'}
    end
    entity_id = nil
  end
end

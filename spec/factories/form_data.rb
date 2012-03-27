FactoryGirl.define do
  factory :form_data do
    sequence(:data) do |n|
      {
        'form'=> {
          "Name Information"=> {
            "First Name" => {
              'value' => "FirstName#{n}"
            }
          },
          "Location"=> {
            "Address" => {
              'value' => "#{n} Main St"
            }
          }
        }
      }
    end
  end
end

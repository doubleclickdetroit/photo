FactoryGirl.define do
  factory :form_type do
    sequence(:data) do |n|
      # todo positions
      {
        'form'=> {
          "Name Information"=> {
            "First Name" => {
              'entity'  => "input",
              'required'=> true
            }
          },
          "Location"=> {
            "Address" => {
              'entity'  => "input",
              'required'=> true
            }
          }
        },
        'controls'=> [
          {
            'title' => "Cancel",
            'entity'=> "anchor",
            'attrs' => {
              'href'=> "/users",
              'rel' => "external"
            }
          },
          {
            'title' => "Submit",
            'entity'=> "submit",
            'value' => "submit",
            'attrs' => { "id"=> "btn-submit" }
          }
        ]
      }
    end
  end
end

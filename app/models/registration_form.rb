class RegistrationForm < Form
  # the form needs to be persisted for FormData
  # but the FormType can and should be hardcoded
  
  # it also needs to grab the user/group info 
  # from the associated Invitation, if any
  
  

  def form_type
    FormType.new :data =>
    {
      'form'=> {
        "Information"=> {
          "First Name" => {
            'entity'  => "input",
            'required'=> true
          },
          "Last Name" => {
            'entity'  => "input",
            'required'=> true
          },
          "Email Address" => {
            'entity'  => "input",
            'required'=> true
          },
          "Password" => {
            'entity'  => "password",
            'required'=> true
          },
          "Confirm Password" => {
            'entity'  => "password",
            'required'=> true
          }
        },
      },
      'controls'=> [
        {
          'title' => "Create my account",
          'entity'=> "button",
          'attrs' => {
            'href'  => "/api/users/",
            'method'=> "POST", 
            'rel'   => "external"
          }
        }
      ]
    }
  end
end


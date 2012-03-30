class RegistrationForm < Form
  # overrides AR 
  def form_type
    FormType.new :data => FORM_HASH
  end

  def generate_form_data_from(invitation)
    invitee = invitation.invitee
    hash    = {} 

    hash['First Name']    = invitee.first_name
    hash['Last Name']     = invitee.last_name
    hash['Email Address'] = invitee.email

    data = { 'form' => { 'Information' => hash } }
    self.form_data = FormData.new :data => data
    self.save
  end

private
  def associate_asset
    # overrides super
  end

  FORM_HASH = 
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

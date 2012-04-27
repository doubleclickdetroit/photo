class FormType < SerializedJSON 
  belongs_to :entity

  def to_hash(form_data_obj=nil)
    return data if form_data_obj.nil?

    hash = data.clone
    # todo get rid of the Hash literal?
    form_type = hash['form'] || {}
    form_data = form_data_obj.data['form']

    # dump 'value's into the FormType 
    form_type.each do |section_name,fields|
      fields.each do |field_name,pairs|
        val = form_data[section_name][field_name].fetch('value') rescue ''
        pairs['value'] = val
      end
    end

    hash['form'] = form_type
    hash
  end


private
end

# # ABBREVIATED EXAMPLE OUTPUT
# {
# 	form: [
# 		{
# 			"Name Information": [
# 				{
# 					title   : "First Name",
# 					entity  : "input",
# 					value   : "John",
# 					required: true,
# 				},
# 			],
# 			"Location": [
# 				{
# 					title   : "Address",
# 					entity  : "input",
# 					value   : "123 Main St.",
# 					required: true,
# 				},
# 			],
# 		}
# 	],
# 	controls: [
# 		{
# 			title : "Cancel",
# 			entity: "anchor",
# 			attrs : {
# 				"href": "/users",
# 				"rel" : "external"
# 			}
# 		},
# 		{
# 			title : "Submit",
# 			entity: "submit",
# 			value : "submit"
# 			attrs : { "id": "btn-submit" }
# 		},
# 	]
# }
#
#
# # FORMDATA CONCERNS ITSELF WITH:
# everything but 'value'

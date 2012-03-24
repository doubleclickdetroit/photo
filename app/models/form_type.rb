class FormType < SerializedJSON 
  belongs_to :entity

  def to_hash(form_data)
    # todo get rid of the Hash literal after dev?
    hash = data || {}

    # form = hash['form']
    # form.map do |header|
    #   fields = form[header]
    #   fields.map do |field|
    #     val = form_data['form'][header][field['title']]
    #     field['value'] = val
    #   end
    #   fields
    # end
    
    hash
  end
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
# 	form: [
# 		{
# 			"Name Information": [
# 				{
# 					title   : "First Name",
# 					value   : "John"
# 				},
# 			],
# 			"Location": [
# 				{
# 					title   : "Address",
# 					value   : "123 Main St."
# 				},
# 			],
# 		}
# 	]

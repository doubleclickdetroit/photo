class FormData < SerializedJSON 
  belongs_to :entity
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
# 			# header
# 			"Location": [
# 			  # field
# 				{
# 					title   : "Address",
# 					value   : "123 Main St."
# 				},
# 			],
# 		}
# 	]
#
# # TENTATIVELY STARTING WITH THIS:
# 	form: [
# 		{
# 		  # header
# 			"Name Information": [
# 				{
# 				  # field
# 					"First Name" : "John"
# 				},
# 			],
# 			"Location": [
# 				{
# 					"Address" : "123 Main St."
# 				},
# 			],
# 		}
# 	]

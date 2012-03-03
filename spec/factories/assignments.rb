# # Read about factories at http://github.com/thoughtbot/factory_girl
# 
# FactoryGirl.define do
#   factory :assignment do
#     entity_id 1
#     assignee_id 1
#   end
# end

Factory.define :assignment do |f|
  # f.assignee_id Factory(:user).id
  # f.entity_id Factory(:).id
end

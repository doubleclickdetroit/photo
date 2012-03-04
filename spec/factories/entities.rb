Factory.define :entity do |f|
  f.sequence(:title) {|n| "Entity #{n}"}
  f.sequence(:text) {|n| "Lorem ipsum #{n}"}
end

Factory.define :task do |f|
  f.sequence(:title) {|n| "Task #{n}"}
  f.sequence(:text) {|n| "Lorem ipsum #{n}"}
  f.type "Task"
end

Factory.define :event do |f|
  f.sequence(:title) {|n| "Event #{n}"}
  f.sequence(:text) {|n| "Lorem ipsum #{n}"}
  f.type "Event"
end
 
# Factory.define :asset do |f|
#   f.sequence(:title) {|n| "Asset #{n}"}
#   f.sequence(:text) {|n| "Lorem ipsum #{n}"}
#   f.type "asset"
# end

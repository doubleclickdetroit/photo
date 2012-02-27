Factory.define :entity do |f|
  f.sequence(:title) {|n| "Entity #{n}"}
  f.sequence(:text) {|n| "Lorem ipsum #{n}"}
end

Factory.define :task do |f|
  f.sequence(:title) {|n| "Task #{n}"}
  f.sequence(:text) {|n| "Lorem ipsum #{n}"}
  f.type "task"
end

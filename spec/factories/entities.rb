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
 
Factory.define :embed do |f|
  f.sequence(:title) {|n| "Embed #{n}"}
  f.sequence(:text) {|n| "Lorem ipsum #{n}"}
  f.type "Embed"
end

Factory.define :milestone do |f|
  f.sequence(:title) {|n| "Milestone #{n}"}
  f.sequence(:text) {|n| "Lorem ipsum #{n}"}
  f.type "Milestone"
end

Factory.define :form do |f|
  f.sequence(:title) {|n| "Form #{n}"}
  f.sequence(:text) {|n| "Lorem ipsum #{n}"}
  f.type "Form"
end

Factory.define :suggestion do |f|
  f.sequence(:title) {|n| "Suggestion #{n}"}
  f.sequence(:text) {|n| "Lorem ipsum #{n}"}
  f.type "Suggestion"
end

Factory.define :correspondence do |f|
  f.sequence(:title) {|n| "Correspondence #{n}"}
  f.sequence(:text) {|n| "Lorem ipsum #{n}"}
  f.type "Correspondence"
end

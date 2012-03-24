FactoryGirl.define do
  factory :project_workflow do
    sequence(:name) {|n| "ProjectWorkflow Name #{n}"}
    group_id 1
  end
end

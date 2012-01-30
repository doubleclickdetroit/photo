Factory.define :user do |f|
  f.sequence(:name) {|n| "foo#{n}"}
  f.sequence(:email) {|n| "foo#{n}@bar.com"}
  f.password "foobarbaz"
  f.password_confirmation { |u| u.password }
end

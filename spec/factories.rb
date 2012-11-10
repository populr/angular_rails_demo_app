Factory.sequence :email do |n|
  "email#{n}@factory.com"
end

Factory.sequence :name do |n|
  "Name#{n}"
end

Factory.define :user do |f|
  f.email { Factory.next(:email) }
  f.password 'secret'
  f.password_confirmation 'secret'
end

Factory.define :recipe do |f|
  f.name { Factory.next(:name) }
  f.association :user
  f.association :ingredient
end

Factory.define :ingredient do |f|
  f.name { Factory.next(:name) }
  f.association :recipe
end

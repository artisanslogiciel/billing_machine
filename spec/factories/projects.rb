# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name 'Backbone'
    entity Entity.find_or_create_by(name: "ACME")
  end
end

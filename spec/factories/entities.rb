# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entity do
    name 'Great Company LLC'
    address1 '1 Mickey Boulevard'
    address2 ''
    zip 77777
    city 'Donald City'
    
    billing_machine true
    time_machine true
    customization_prefix 'agilidee'
    
    after(:create) do |entity|
      #id_card.entity.update_attribute(:current_id_card_id,id_card.id)
      FactoryGirl.create(:id_card, entity: entity )    
    end
  end
end

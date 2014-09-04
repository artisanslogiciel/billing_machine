# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :id_card do
    entity_name "AGILiDEE"
    entity
    legal_form 'SA'
    capital 1000000000
    registration_city 'Gotham City'
    registration_number '123456789'
    ape_naf '6258'
    address1 '72 rue du ROR'
    zip '72054'
    city 'Kaukura'
    siret 'FR 1234569123'
    intracommunity_vat '123456789123'
    contact_full_name 'Bozo LECLOWN'
    contact_phone '0400000000'
    contact_fax '+33 400000000'
    contact_email 'bozo_leclown@pinder.com'
    iban 'FR 456 253 645 459'
    bic_swift 'PSSTTHEGAME'
    bank_name 'My Bank Name'
    bank_address 'My Bank Addresse'
    custom_info_1 'Long string to trigger a line break and test the layout in the invoice PDF generators'

    after(:create) do |id_card|
      id_card.entity.update_attribute(:current_id_card_id,id_card.id)
    end

  end
end
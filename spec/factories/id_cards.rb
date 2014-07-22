# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :id_card do
    name "AGILiDEE"
    entity
    legal_form 'SA'
    capital 1000000000
    registration_number '123456789'
    ape_naf '6258'
    address1 '72 rue du ROR'
    zip '72054'
    city 'Kaukura'
    siret 'FR 1234569123'
    intracommunity_vat '123456789123'
    contact_name 'Bozo LECLOWN'
    contact_phone '045869165'
    contact_fax '0635648195'
    contact_email 'bozo_leclown@pinder.com'
    iban 'FR 456 253 645 459'
    bic_swift 'lihlhkjgkg'
    custom_info_1 'Mentions qui doivent etre assez longues pour pouvoir remplir tout le bas de page'
  end
end

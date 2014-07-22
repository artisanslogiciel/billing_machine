ActiveAdmin.register IdCard do
  actions :all, :except => [:destroy]

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :name, :siret, :legal_form, :capital, :registration_number,
    :intracommunity_vat, :address1, :address2, :zip, :city, :phone,
    :contact_name, :contact_phone, :contact_fax, :contact_address_1, :contact_address_2,
    :contact_zip, :contact_city, :iban, :bic_swift, :bank_name, :bank_address,
    :ape_naf, :custom_info_1, :custom_info_2, :custom_info_3

  scope_to :current_user

  config.clear_sidebar_sections!

  controller do
    def create
      @id_card = IdCard.new(permitted_params['id_card'])
      @id_card.entity = current_user.entity
      create!
    end
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name, :as => :string, :input_html => { :id => 'id-card-name' }
      f.input :siret, :as => :string, :input_html => { :id => 'id-card-siret' }
      f.input :legal_form, :as => :string, :input_html => { :id => 'id-card-legal-form' }
      f.input :capital, :as => :number, :input_html => { :id => 'id-card-capital' }
      f.input :registration_number, :as => :string, :input_html => { :id => 'id-card-registration-number' }
      f.input :intracommunity_vat, :as => :string, :input_html => { :id => 'id-card-intracommunity-vat' }
      f.input :address1, :as => :string, :input_html => { :id => 'id-card-address1' }
      f.input :address2, :as => :string, :input_html => { :id => 'id-card-address2' }
      f.input :zip, :as => :number, :input_html => { :id => 'id-card-zip' }
      f.input :city, :as => :string, :input_html => { :id => 'id-card-city' }
      f.input :phone, :as => :string, :input_html => { :id => 'id-card-phone' }
      f.input :contact_name, :as => :string, :input_html => { :id => 'id-card-contact-name' }
      f.input :contact_phone, :as => :string, :input_html => { :id => 'id-card-contact-phone' }
      f.input :contact_fax, :as => :string, :input_html => { :id => 'id-card-contact-fax' }
      f.input :contact_address_1, :as => :string, :input_html => { :id => 'id-card-contact-address-1' }
      f.input :contact_address_2, :as => :string, :input_html => { :id => 'id-card-contact-address-2' }
      f.input :contact_zip, :as => :string, :input_html => { :id => 'id-card-contact-zip' }
      f.input :contact_city, :as => :string, :input_html => { :id => 'id-card-contact-city' }
      f.input :iban, :as => :string, :input_html => { :id => 'id-card-iban' }
      f.input :bic_swift, :as => :string, :input_html => { :id => 'id-card-bic-swift' }
      f.input :bank_name, :as => :string, :input_html => { :id => 'id-card-bank-name' }
      f.input :bank_address, :as => :string, :input_html => { :id => 'id-card-bank-address' }
      f.input :ape_naf, :as => :string, :input_html => { :id => 'id-card-ape-naf' }
      f.input :custom_info_1, :as => :string, :input_html => { :id => 'id-card-custom-info-1' }
      f.input :custom_info_2, :as => :string, :input_html => { :id => 'id-card-custom-info-2' }
      f.input :custom_info_3, :as => :string, :input_html => { :id => 'id-card-custom-info-3' }
    end
    f.actions
  end

end

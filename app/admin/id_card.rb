ActiveAdmin.register IdCard do
  actions :all, :except => [:destroy]

  attributes_used = [
    :logo,
    :id_card_name,
    :entity_name,
    :legal_form,
    :capital,
    :siret,
    :registration_city,
    :registration_number,
    :intracommunity_vat,
    :iban,
    :bic_swift,
    :bank_name,
    :bank_address,
    :ape_naf,
    :phone,
    :address1,
    :address2,
    :zip,
    :city,
    :contact_full_name,
    :contact_phone,
    :contact_fax,
    :contact_email,
    :contact_address_1,
    :contact_address_2,
    :contact_zip,
    :contact_city,
    :custom_info_1,
    :custom_info_2,
    :custom_info_3]
  attributes_with_default_display = attributes_used - [:logo]

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params attributes_used

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
      attributes_with_custom_forms = [:logo, :id_card_name, :custom_info_1, :custom_info_2, :custom_info_3]
      attributes_with_default_forms = attributes_used - attributes_with_custom_forms

      f.input :id_card_name, :required => true, :placeholder => "name to describe this id card, e.g.`new 2014 logo`"

      f.input :logo, :hint => f.template.image_tag(f.object.logo.url(:thumb))

      attributes_with_default_forms.each do |attr|
        f.input attr
      end

      f.input :custom_info_1, :input_html => { :rows => 1 }
      f.input :custom_info_2, :input_html => { :rows => 1 }
      f.input :custom_info_3, :input_html => { :rows => 1 }
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :logo do
        image_tag(ad.logo.url(:thumb))
      end
      attributes_with_default_display.each do |attr|
        row attr
      end
    end
  end

  index do
    default_actions
    column :id_card_name
    column :entity_name
    column :legal_form
  end

end

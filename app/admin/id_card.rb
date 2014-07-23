ActiveAdmin.register IdCard do
  actions :all, :except => [:destroy]

  attributes_used = [
    :logo,
    :name,
    :legal_form,
    :capital,
    :siret,
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
    :contact_name,
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
      attributes_with_custom_forms = [:logo, :custom_info_1, :custom_info_2, :custom_info_3]
      attributes_with_default_forms = attributes_used - attributes_with_custom_forms

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

  # TODO, DO NOT MERGE
  # Remove "Logo File Name","Logo Content Type","Logo File Size","Logo Updated At"
  # from Show and index
  # and think about adding thumbmail to index and show
#  show do |ad|
#    attributes_table do
#      row :name
#      row :logo do
#        image_tag(ad.logo.url(:thumb))
#      end
#    end
#  end

end

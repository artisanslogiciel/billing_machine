ActiveAdmin.register Customer do
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :name, :short_name, :address1, :address2, :zip, :city, :country
  # permit_params :list, :of, :attributes, :on, :model

  form do |f|
    f.inputs 'Details' do
      f.input :name, :as => :string, :input_html => { :id => 'customer-name' }
      f.input :short_name, :as => :string, :input_html => { :id => 'customer-short-name' }
      f.input :address1, :as => :string, :input_html => { :id => 'customer-address1' }
      f.input :address2, :as => :string, :input_html => { :id => 'customer-address2' }
      f.input :zip, :as => :number, :input_html => { :id => 'customer-zip' }
      f.input :city, :as => :string, :input_html => { :id => 'customer-city' }
      f.input :country, :as => :string, :input_html => { :id => 'customer-country' }
    end
    f.actions
  end

end

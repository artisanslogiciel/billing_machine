ActiveAdmin.register Customer do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  form do |f|
    f.inputs 'Details' do
      f.input :name, :as => :string
      f.input :short_name, :as => :string
      f.input :address1, :as => :string
      f.input :address2, :as => :string
      f.input :zip, :as => :number
      f.input :city, :as => :string
      f.input :country, :as => :string
    end
    f.actions
  end

end

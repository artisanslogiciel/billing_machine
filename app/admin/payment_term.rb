ActiveAdmin.register PaymentTerm do
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :label

  scope_to :current_user

  config.clear_sidebar_sections!

  controller do
    def create
      @payment_term = PaymentTerm.new(permitted_params['payment_term'])
      @payment_term.entity_id = current_user.entity_id
      create!
    end
  end

    form do |f|
      f.inputs 'Payment Term' do
        f.input :label
      end
      f.actions
    end

end

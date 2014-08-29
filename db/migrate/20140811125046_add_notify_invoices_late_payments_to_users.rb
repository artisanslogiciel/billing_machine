class AddNotifyInvoicesLatePaymentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notify_invoices_late_payments, :boolean, default: false
  end
end

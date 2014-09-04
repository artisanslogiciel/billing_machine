class UserMailer < ActionMailer::Base
  default from: "support@agilidee.com"
  def invoice_alert(invoice)
    @invoice = invoice
    users = invoice.entity.users.where(notify_invoices_late_payments: true).map(&:email)
    mail :to => users, :subject => 'Facture en alerte'
  end
end

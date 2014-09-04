require "spec_helper"

describe UserMailer do
  describe "invoice_alert" do 
 
    it 'should generate a valid email' do
      invoice = FactoryGirl.create(:invoice)
      alice = FactoryGirl.create(:user, entity: invoice.entity, notify_invoices_late_payments: true)
      bob = FactoryGirl.create(:user, entity: invoice.entity, notify_invoices_late_payments: false)
      email = UserMailer.invoice_alert(invoice)
      email.to.should eq([alice.email])
      email.from.should eq(["support@agilidee.com"])
      email.body.should include invoice_url(invoice)
    end
  end
end

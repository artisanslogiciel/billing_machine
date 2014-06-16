namespace :db do
  desc 'initialize development database'
  task :init_development_base => [:environment, :migrate]  do 
    entity=FactoryGirl.create(:entity)
    FactoryGirl.create(:admin_user, email: "admin@admin.com" , password: "adminadmin", entity: entity)
    FactoryGirl.create(:customer, entity: entity)
    FactoryGirl.create(:payment_term, entity: entity)
    FactoryGirl.create(:invoice, entity: entity, customer: Customer.first, payment_term: PaymentTerm.first)
    FactoryGirl.create(:invoice_line, invoice: Invoice.first)
    FactoryGirl.create(:invoice_line, invoice: Invoice.first, label: "truc")
    FactoryGirl.create(:time_slice, user: User.first)
    puts "Now you can log in with #{User.first.email} with password: adminadmin"
  end
end
namespace :db do
  desc 'initialize development database'
  task :init_development_base => [:environment, :migrate]  do 
    id_card = FactoryGirl.create(:id_card)
    entity = id_card.entity
    FactoryGirl.create(:admin_user, email: "admin@admin.com" , password: "adminadmin", entity: entity)
    FactoryGirl.create(:customer, entity: entity)
    FactoryGirl.create(:payment_term, entity: entity)
    FactoryGirl.create(:invoice, id_card: id_card, customer: Customer.first, payment_term: PaymentTerm.first)
    FactoryGirl.create(:invoice_line, invoice: Invoice.first)
    FactoryGirl.create(:invoice_line, invoice: Invoice.first, label: "truc")
    FactoryGirl.create(:project, entity: entity)
    FactoryGirl.create(:time_slice, user: User.first, project: Project.first)
    puts "Now you can log in with #{User.first.email} with password: adminadmin"
  end
end

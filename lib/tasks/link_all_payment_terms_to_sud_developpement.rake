namespace :migration do
  desc 'Allow existing payment_terms to remain usable since issue56'
  task :link_all_payment_terms_to_sud_developpement => :environment do
    sud_developpement = Entity.find_by_customization_prefix('sud_developpement')
      PaymentTerm.update_all entity_id: sud_developpement
  end
end
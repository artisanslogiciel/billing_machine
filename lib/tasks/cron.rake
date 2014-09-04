namespace :cron do
  desc "Warn users for very late invoice"
  task :daily => :environment do
    
    date = Date.today 
    Invoice.where(paid: false).each do |invoice|
      puts(invoice.id)
    end

  end
end
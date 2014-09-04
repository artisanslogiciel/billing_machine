namespace :cron do
  desc "Warn users for very late invoice"
  task :daily => :environment do
    Invoice.where(paid: false).where(due_date: Date.today - 16.days).each do |invoice|
      UserMailer.invoice_alert(invoice).deliver
    end    
  end
end
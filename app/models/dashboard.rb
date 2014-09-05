class Dashboard
  def customer_debt user
    user.entity.invoices.joins(:customer).select("customer_id, sum(total_duty) as total_duty").group(:customer_id).where(paid: false).map {|i| [i.customer.name, i.total_duty]}     
  end
end
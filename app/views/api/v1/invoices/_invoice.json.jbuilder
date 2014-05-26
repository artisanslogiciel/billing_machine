json.(invoice, :id, :unique_index, :label, :date, :created_at, :updated_at, :customer_id,
:payment_term_id, :tracking_id)
json.lines_attributes invoice.lines do |line|
  json.(line, :id, :label, :unit)
  json.quantity line.quantity.to_f
  json.unit_price line.unit_price.to_f
  json.total line.total.to_f
end
json.total_duty invoice.total_duty.to_f
json.vat invoice.vat.to_f
json.total_all_taxes invoice.total_all_taxes.to_f
json.balance invoice.balance.to_f
json.advance invoice.advance.to_f

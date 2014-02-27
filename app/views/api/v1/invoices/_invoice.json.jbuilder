json.(invoice, :id, :label, :date, :total_duty, :vat, :total_all_taxes, :advance, :balance, :created_at, :updated_at)
json.lines_attributes invoice.lines do |line|
  json.(line, :id, :label, :quantity, :unit, :unit_price, :total)
end
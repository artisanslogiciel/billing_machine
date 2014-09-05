require 'spec_helper'

describe Dashboard do
  describe 'customer_debt' do
    it 'should return the curstomer list with pending invoices' do
      entity = FactoryGirl.create(:entity)
      user = FactoryGirl.create(:user, entity_id: entity.id)
      i1 = FactoryGirl.create(:invoice, id_card: entity.current_id_card, paid: false, total_duty: 100.0)
      i2 = FactoryGirl.create(:invoice, customer_id: i1.customer_id, id_card: entity.current_id_card, paid: true, total_duty: 100)
      i3 = FactoryGirl.create(:invoice, paid: false, total_duty: 90.0)
      d = Dashboard.new
      d.customer_debt(user).should eq([[i1.customer.name, 100.0]])
    end
    it 'should sum the total for one customer' do
      entity = FactoryGirl.create(:entity)
      user = FactoryGirl.create(:user, entity_id: entity.id)
      i1 = FactoryGirl.create(:invoice, id_card: entity.current_id_card, paid: false, total_duty: 100.0)
      i2 = FactoryGirl.create(:invoice, customer_id: i1.customer_id, id_card: entity.current_id_card, paid: false, total_duty: 100)
      d = Dashboard.new
      d.customer_debt(user).should eq([[i1.customer.name, 200.0]])
    end
  end

end

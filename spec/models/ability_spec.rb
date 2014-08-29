require 'spec_helper'
require "cancan/matchers"

describe "Abilities" do
  let(:ability) { Ability.new(user) }

  subject{ ability }

  describe '#invoices' do
    let(:id_card) { FactoryGirl.create(:id_card, entity: user.entity) }
    context 'when user cannot access it' do
      let(:user) {FactoryGirl.create(:user, billing_machine: false)}
      it 'should only provide access if billing machine is active' do
        invoice = FactoryGirl.create(:invoice, id_card: id_card)
        ability.should_not be_able_to(:read, invoice)
        ability.should_not be_able_to(:write, invoice)
        ability.should_not be_able_to(:read, Invoice)
        ability.should_not be_able_to(:write, Invoice)
      end
    end
    context 'when entity has not been granted' do
      let(:entity) {FactoryGirl.create(:entity, billing_machine: false)}
      let(:user) {FactoryGirl.create(:user, billing_machine: true, entity: entity)}
      it 'should only provide access if billing machine is active' do
        invoice = FactoryGirl.create(:invoice, id_card: id_card)
        ability.should_not be_able_to(:read, invoice)
        ability.should_not be_able_to(:write, invoice)
        ability.should_not be_able_to(:read, Invoice)
        ability.should_not be_able_to(:write, Invoice)
      end
    end
  end

  describe '#time_slices' do
    context 'when user cannot access it' do
      let(:user) {FactoryGirl.create(:user, time_machine: false)}
      it 'should only provide access if billing machine is active' do
        time_slice = FactoryGirl.create(:time_slice, user: user)
        ability.should_not be_able_to(:read, time_slice)
        ability.should_not be_able_to(:write, time_slice)
        ability.should_not be_able_to(:read, TimeSlice)
        ability.should_not be_able_to(:write, TimeSlice)
      end
    end
    context 'when entity has not been granted' do
      let(:entity) {FactoryGirl.create(:entity, time_machine: false)}
      let(:user) {FactoryGirl.create(:user, billing_machine: true, entity: entity)}
      it 'should only provide access if billing machine is active' do
        time_slice = FactoryGirl.create(:time_slice, user: user)
        ability.should_not be_able_to(:read, time_slice)
        ability.should_not be_able_to(:write, time_slice)
        ability.should_not be_able_to(:read, TimeSlice)
        ability.should_not be_able_to(:write, TimeSlice)
      end
    end
  end
end
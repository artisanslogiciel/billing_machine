require 'spec_helper'

describe PaymentTerm do
  it 'should have a valid factory' do
    FactoryGirl.build(:payment_term).should be_valid
  end
end

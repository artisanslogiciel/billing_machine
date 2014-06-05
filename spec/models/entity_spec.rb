require 'spec_helper'

describe Entity do
  it 'should have a valid factory' do
    FactoryGirl.build(:entity).should be_valid
  end
  it {should have_many :invoices}
  it {should have_many :payment_terms}
  it {should have_many :customers}
  it {should respond_to :customization_prefix}
  it {should validate_presence_of :customization_prefix }
end

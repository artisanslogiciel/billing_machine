require 'spec_helper'

describe Entity do
  it 'should have a valid factory' do
    FactoryGirl.build(:entity).should be_valid
  end
  it {should have_many :invoices}
end

require 'spec_helper'

describe IdCard do
  it 'should have a valid factory' do
    FactoryGirl.build(:id_card).should be_valid
  end

  it {should validate_presence_of :entity}
  it {should have_many :invoices}
end

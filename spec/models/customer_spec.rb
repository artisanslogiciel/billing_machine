require 'spec_helper'

describe Customer do
  it 'should have a valid factory' do
    FactoryGirl.build(:customer).should be_valid
  end
  it { should belong_to :entity}
  it { should validate_presence_of :entity }

  it 'should display name order by name' do
    FactoryGirl.create(:customer, name: 'CCLIENT')
    FactoryGirl.create(:customer, name: 'BCLIENT')
    FactoryGirl.create(:customer, name: 'DCLIENT')
    FactoryGirl.create(:customer, name: 'ACLIENT')
    all_customer_name = Customer.all.collect(&:name)
    all_customer_name.should == ['ACLIENT','BCLIENT','CCLIENT','DCLIENT']
  end
end

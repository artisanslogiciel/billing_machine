require 'spec_helper'

describe Customer do
  it 'should have a valid factory' do
    FactoryGirl.build(:customer).should be_valid
  end
  it { should belong_to :entity}
  it { should validate_presence_of :entity }
end

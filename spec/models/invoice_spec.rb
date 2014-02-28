require 'spec_helper'

describe Invoice do
  it 'should have a valid factory' do
    FactoryGirl.build(:invoice).should be_valid
  end
  it { should belong_to :customer }
  it { should belong_to :payment_term }
  it { should belong_to :entity }
  it { should validate_presence_of :entity }
  it { should have_many :lines}
  describe 'unique_index' do
    it 'should be assigned upon creation' do
      entity = FactoryGirl.create(:entity, unique_index: 69)
      invoice = FactoryGirl.create(:invoice, entity: entity)
      invoice.unique_index.should eq(70)
      entity.reload.unique_index.should eq(70)
    end
  end
end

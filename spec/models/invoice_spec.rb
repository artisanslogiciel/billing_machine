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
      invoice = FactoryGirl.create(:invoice, entity: entity, date:'2014-02-01')
      invoice.unique_index.should eq(70)
      entity.reload.unique_index.should eq(70)
    end
    it 'should be assigned upon creation' do
      entity = FactoryGirl.create(:entity, unique_index: nil)
      invoice1 = FactoryGirl.create(:invoice, entity: entity, date:'2014-02-01')
      invoice1.unique_index.should eq(1)
      entity.reload.unique_index.should eq(1)

      invoice2 = FactoryGirl.create(:invoice, entity: entity, date:'2014-02-01')
      invoice2.unique_index.should eq(2)
      entity.reload.unique_index.should eq(2)

    end
  end

  describe 'tracking_id' do
    it 'should return correct tracking_id for sud_developpement' do
      entity = FactoryGirl.create(:entity, unique_index: 69, customization_prefix: 'sud_developpement')
      invoice = FactoryGirl.create(:invoice, entity: entity, date:'2014-02-01')
      invoice.tracking_id.should eq('20140201-70')
    end
    it 'should return correct tracking_id for sud_developpement when no date for invoice' do
      entity = FactoryGirl.create(:entity, unique_index: 45, customization_prefix: 'sud_developpement')
      invoice = FactoryGirl.create(:invoice, entity: entity, date: nil)
      invoice.tracking_id.should eq('46')
    end

    it 'should return correct tracking_id for agilidee' do
      entity = FactoryGirl.create(:entity, unique_index: 36, customization_prefix: 'agilidee')
      invoice = FactoryGirl.create(:invoice, entity: entity, date:'2013-05-20')
      invoice.tracking_id.should eq('1337')
    end
    it 'should return correct tracking_id for agilidee' do
      entity = FactoryGirl.create(:entity, unique_index: 141, customization_prefix: 'agilidee')
      invoice = FactoryGirl.create(:invoice, entity: entity, date:'2014-05-20')
      invoice.tracking_id.should eq('14142')
    end
    it 'should return correct tracking_id for agilidee when no date for invoice' do
      entity = FactoryGirl.create(:entity, unique_index: 666, customization_prefix: 'agilidee')
      invoice = FactoryGirl.create(:invoice, entity: entity, date: nil)
      invoice.tracking_id.should eq('667')
    end
  end

  describe 'balance' do
    it 'should be calculated upon saving' do
      invoice = FactoryGirl.create(:invoice, total_all_taxes: 100, advance: 40, balance: 10)
      invoice.balance.should eq(60.0)
    end
    it 'should be calculated upon saving' do
      invoice = FactoryGirl.create(:invoice, total_all_taxes: 100, advance: nil, balance: nil)
      invoice.balance.should eq(100.0)
    end
  end

  describe 'pdf' do
    it 'should return the entities\'s customization type' do
      entity = FactoryGirl.create(:entity, customization_prefix: 'sud_developpement')
      invoice = FactoryGirl.create(:invoice, entity: entity)
      invoice.pdf.should be_a SudDeveloppementInvoice
    end
    it 'should return the entities\'s customization type' do
      entity = FactoryGirl.create(:entity, customization_prefix: 'agilidee')
      invoice = FactoryGirl.create(:invoice, entity: entity)
      invoice.pdf.should be_a AgilideeInvoice
    end
  end
end

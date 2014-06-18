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
    it 'should return correct tracking_id for sud_developpement for first invoice' do
      entity = FactoryGirl.create(:entity, unique_index: nil, customization_prefix: 'sud_developpement')
      invoice = FactoryGirl.create(:invoice, entity: entity, date:'2014-02-01')
      invoice.tracking_id.should eq('20140201-1')
    end
    it 'should return correct tracking_id for sud_developpement' do
      entity = FactoryGirl.create(:entity, unique_index: 69, customization_prefix: 'sud_developpement')
      invoice = FactoryGirl.create(:invoice, entity: entity, date:'2014-02-01')
      invoice.tracking_id.should eq('20140201-70')
    end

    it 'should return correct tracking_id for agilidee for first invoice' do
      entity = FactoryGirl.create(:entity, unique_index: nil, customization_prefix: 'agilidee')
      invoice = FactoryGirl.create(:invoice, entity: entity, date:'2010-05-20')
      invoice.tracking_id.should eq('1001')
    end
    it 'should return correct tracking_id for agilidee' do
      entity = FactoryGirl.create(:entity, unique_index: 36, customization_prefix: 'agilidee')
      invoice = FactoryGirl.create(:invoice, entity: entity, date:'2013-05-20')
      invoice.tracking_id.should eq('1337')
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

  describe 'to_csv' do
    let(:entity) { FactoryGirl.create(:entity) }
    let(:columns_names) {"Date;Client;Paiement;Label;Montant HT;Montant TVA;Montant TTC;Acompte;Solde à payer;Index unique;Taux TVA\n"}
    it 'should return csv' do
      invoice0 = FactoryGirl.create(:invoice, entity: entity)
      invoice1 = FactoryGirl.create(:invoice, entity: entity)
      invoices = Invoice.all
      csv_output = invoices.to_csv

      csv_output.should be ==
        columns_names +
        "#{invoice0.date};#{invoice0.customer.name};#{invoice0.payment_term.label};#{invoice0.label};#{invoice0.total_duty};"+
            "#{invoice0.vat};#{invoice0.total_all_taxes};#{invoice0.advance};#{invoice0.balance};#{invoice0.unique_index};#{invoice0.vat_rate}\n"+
        "#{invoice1.date};#{invoice1.customer.name};#{invoice1.payment_term.label};#{invoice1.label};#{invoice1.total_duty};"+
            "#{invoice1.vat};#{invoice1.total_all_taxes};#{invoice1.advance};#{invoice1.balance};#{invoice1.unique_index};#{invoice1.vat_rate}\n"
    end
  end
end

# encoding: utf-8
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
    let(:columns_names) {'"Date";"Numéro";"Objet";"Client";"Adresse 1";"Adresse 2";"Code postal";"Ville";"Pays";"Montant HT";"Taux TVA";"Montant TVA";"Montant TTC";"Acompte";"Solde à payer"'+"\n"}
    it 'should return csv' do
      invoice0 = FactoryGirl.create(:invoice, total_duty: 9.99, vat_rate: 19.6, vat: 23.2, total_all_taxes: 43.35, advance: 3.5, label: "çé,à,ç,@", entity: entity)
      invoice1 = FactoryGirl.create(:invoice, total_duty: 13.00, vat_rate: 20.0, vat: 23.0, total_all_taxes: 43.0, advance: 3.0, entity: entity)
      csv_output = Invoice.to_csv

      csv_output.should be ==
        columns_names +
        "\"#{invoice0.date}\";\"#{invoice0.tracking_id}\";\"çé,à,ç,@\";\"#{invoice0.customer.name}\";\"#{invoice0.customer.address1}\";"+
        "\"#{invoice0.customer.address2}\";\"#{invoice0.customer.zip}\";\"#{invoice0.customer.city}\";\"#{invoice0.customer.country}\";\"9,99\";"+
            "\"19,6\";\"23,2\";\"43,35\";\"3,5\";\"39,85\"\n"+
        "\"#{invoice1.date}\";\"#{invoice1.tracking_id}\";\"#{invoice1.label}\";\"#{invoice1.customer.name}\";\"#{invoice1.customer.address1}\";"+
        "\"#{invoice1.customer.address2}\";\"#{invoice1.customer.zip}\";\"#{invoice1.customer.city}\";\"#{invoice1.customer.country}\";\"13,0\";"+
            "\"20,0\";\"23,0\";\"43,0\";\"3,0\";\"40,0\"\n"
    end
    it 'should return expected csv with nil values' do
      invoice0 = FactoryGirl.create(:invoice, entity: entity, total_duty: nil,
        vat_rate: nil, vat: nil, total_all_taxes: 0, advance: nil, label: nil,
        customer: nil, payment_term: nil, date: nil)
      csv_output = Invoice.to_csv

      csv_output.should be ==
        columns_names +
        '"";"1";"";"";"";"";"";"";"";"";"";"";"0,0";"0,0";"0,0"' + "\n"
    end
  end
end

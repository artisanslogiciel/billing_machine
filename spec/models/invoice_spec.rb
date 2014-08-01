# encoding: utf-8
require 'spec_helper'

describe Invoice do
  it 'should have a valid factory' do
    FactoryGirl.build(:invoice).should be_valid
  end
  let(:id_card) { FactoryGirl.create(:id_card, entity: entity)}
  it { should belong_to :customer }
  it { should belong_to :payment_term }
  it { should have_many :lines }
  it { should validate_presence_of :id_card }

  describe 'unique_index' do
    context ' when unique index is 69' do
      let(:entity) { FactoryGirl.create(:entity, unique_index: 69) }

      it 'should be assigned upon creation' do
        invoice = FactoryGirl.create(:invoice, id_card: id_card, date:'2014-02-01')
        invoice.unique_index.should eq(70)
        entity.reload.unique_index.should eq(70)
      end
    end
    context ' when unique index is nil' do
      let(:entity) { FactoryGirl.create(:entity, unique_index: nil) }

      it 'should be assigned upon creation' do
        invoice1 = FactoryGirl.create(:invoice, id_card: id_card, date:'2014-02-01')
        invoice1.unique_index.should eq(1)
        entity.reload.unique_index.should eq(1)

        invoice2 = FactoryGirl.create(:invoice, id_card: id_card, date:'2014-02-01')
        invoice2.unique_index.should eq(2)
        entity.reload.unique_index.should eq(2)
      end
    end
  end

  describe 'tracking_id' do
    it 'should return correct tracking_id for sud_developpement for first invoice' do
      entity = FactoryGirl.create(:entity, unique_index: nil, customization_prefix: 'sud_developpement')
      id_card = FactoryGirl.create(:id_card, entity: entity)
      invoice = FactoryGirl.create(:invoice, id_card: id_card, date:'2014-02-01')
      invoice.tracking_id.should eq('20140201-1')
    end
    it 'should return correct tracking_id for sud_developpement' do
      entity = FactoryGirl.create(:entity, unique_index: 69, customization_prefix: 'sud_developpement')
      id_card = FactoryGirl.create(:id_card, entity: entity)
      invoice = FactoryGirl.create(:invoice, id_card: id_card, date:'2014-02-01')
      invoice.tracking_id.should eq('20140201-70')
    end

    it 'should return correct tracking_id for agilidee for first invoice' do
      entity = FactoryGirl.create(:entity, unique_index: nil, customization_prefix: 'agilidee')
      id_card = FactoryGirl.create(:id_card, entity: entity)
      invoice = FactoryGirl.create(:invoice, id_card: id_card, date:'2010-05-20')
      invoice.tracking_id.should eq('1001')
    end
    it 'should return correct tracking_id for agilidee' do
      entity = FactoryGirl.create(:entity, unique_index: 36, customization_prefix: 'agilidee')
      id_card = FactoryGirl.create(:id_card, entity: entity)
      invoice = FactoryGirl.create(:invoice, id_card: id_card, date:'2013-05-20')
      invoice.tracking_id.should eq('1337')
    end
  end

  describe 'paid' do
    it 'should be false by default' do
        invoice = FactoryGirl.create(:invoice)
        invoice.paid.should eq(false)
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
      id_card = FactoryGirl.create(:id_card, entity: entity)
      invoice = FactoryGirl.create(:invoice, id_card: id_card)
      invoice.pdf.should be_a SudDeveloppementInvoice
    end
    it 'should return the entities\'s customization type' do
      entity = FactoryGirl.create(:entity, customization_prefix: 'agilidee')
      id_card = FactoryGirl.create(:id_card, entity: entity)
      invoice = FactoryGirl.create(:invoice, id_card: id_card)
      invoice.pdf.should be_a AgilideeInvoice
    end
  end

  describe 'to_csv' do
    let(:id_card) { FactoryGirl.create(:id_card) }
    let(:customer) { FactoryGirl.create(:customer, name: "cutomerName", address1: "address1", address2: "address2",
      zip: "13005", city: "Marseille", country: "country") }
    let(:columns_names) {'"Date";"Numéro";"Objet";"Client";"Adresse 1";"Adresse 2";"Code postal";"Ville";"Pays";"Montant HT";"Taux TVA";"Montant TVA";"Montant TTC";"Acompte";"Solde à payer"'+"\n"}
    it 'should return csv' do
      invoice0 = FactoryGirl.create(:invoice, label: "invoiceLabel", date: "2014-07-31", unique_index: 1, total_duty: 9.99, vat_rate: 19.6, vat: 23.2, total_all_taxes: 43.35, advance: 3.5, id_card: id_card, customer: customer)
      invoice0.dup.update(label: "çé,à,ç,@", date: "2014-08-01", unique_index: 2, total_duty: 13.00, vat_rate: 20.0, vat: 23.0, total_all_taxes: 43.0, advance: 3.0)
      csv_output = Invoice.to_csv

      csv_output.should be ==
        columns_names +
        '"2014-07-31";"1401";"invoiceLabel";"cutomerName";"address1";"address2";'\
        '"13005";"Marseille";"country";"9,99";"19,6";"23,2";"43,35";"3,5";"39,85"' + "\n"\
        '"2014-08-01";"1402";"çé,à,ç,@";"cutomerName";"address1";"address2";'\
        '"13005";"Marseille";"country";"13,0";"20,0";"23,0";"43,0";"3,0";"40,0"' + "\n"
    end
    it 'should return expected csv with nil values' do
      invoice0 = FactoryGirl.create(:invoice, id_card: id_card, total_duty: nil,
        vat_rate: nil, vat: nil, total_all_taxes: 0, advance: nil, label: nil,
        customer: nil, payment_term: nil, date: nil)
      csv_output = Invoice.to_csv

      csv_output.should be ==
        columns_names +
        '"";"1";"";"";"";"";"";"";"";"";"";"";"0,0";"0,0";"0,0"' + "\n"
    end
  end
end

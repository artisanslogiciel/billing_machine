# encoding: utf-8
require 'spec_helper'

describe AgilideeInvoice, pdfs: true do

  def self.it_should_write(string)
    it "should write '#{string}'" do
      text.strings.should include string
    end
  end

  let(:customer) { FactoryGirl.create(:customer, city: 'Mickey City',
    address2: 'address2 value', country: 'Hong Kong') }
  let(:invoice) { FactoryGirl.create(:invoice, total_duty: 1000, vat: 196,
    total_all_taxes: 1196, advance: 50, balance: 1146 , customer: customer,
    date: '2014-04-16', vat_rate: 19.6)}

  let(:invoice_line) { FactoryGirl.create(:invoice_line,
    invoice_id: invoice.id,
    quantity: 43.5,
    unit_price: 2,
    total: 10.99) }

  let(:invoice_line_2) { FactoryGirl.create(:invoice_line,
    invoice_id: invoice.id,
    label: 'Truc',
    quantity: 4.0,
    unit_price: 400.00,
    total: 1600.00) }

  let(:pdf) { FactoryGirl.build(:agilidee_invoice, invoice: invoice) }

  describe "#initialize" do
    it 'inherits from Prawn::Document' do
      pdf.should be_kind_of(Prawn::Document)
    end

    it 'should assign @invoice' do
      pdf.invoice.should eq(invoice)
    end
  end

  describe "#build" do
    let(:text) { PDF::Inspector::Text.analyze(pdf.render) }
    before do
      invoice.lines << invoice_line
      invoice.lines << invoice_line_2
      pdf.build
    end
    context 'in Mentions légales - Coin supérieur droit' do
      it_should_write 'SIRET 522 162 379 00013 APE 6202A'
      it_should_write 'SARL au capital de 10.000 euros'
      it_should_write 'RCS MARSEILLE 522 162 379'
      it_should_write 'N° TVA FR 05 522 162 379 000 13'
      it_should_write '46 Avenue des Chartreux'
      it_should_write '13004 Marseille'
    end

    context 'in Entete de facturation' do

    it_should_write 'Facture'

    it "should write invoice tracking id" do
      text.strings.should include ' N°' + invoice.tracking_id
    end
    it "should write 'Marseille le ' and invoice date" do
      text.strings.should include 'Marseille le ' + '16 avril 2014'
    end

      context 'in Informations contact AGILiDEE' do
        it_should_write 'Contact :'
        it_should_write ' Benoit Gantaume'
        it_should_write 'Tél :'
        it_should_write ' +33.6.76.31.22.91'
        it_should_write 'Fax:'
        it_should_write ' +33.9.72.14.07.28'
        it_should_write 'Email:'
        it_should_write ' benoit.gantaume@agilidee.com'
      end

      context 'in Informations client' do
        it_should_write 'A l’attention de :'

        it "should write customer name" do
          text.strings.should include invoice.customer.name
        end

        it "should write customer address" do
          text.strings.should include invoice.customer.address1
          text.strings.should include invoice.customer.address2
        end

        it "should write customer zip and city" do
          text.strings.should include invoice.customer.zip.to_s +
           ' ' + invoice.customer.city.to_s
        end

        it "should write customer country" do
          text.strings.should include invoice.customer.country
        end
      end # context in Informations client
    end # context in Entete de facturation

    it "shoud write 'Objet :' and invoice label" do
      text.strings.should include 'Objet :'
      text.strings.should include ' ' + invoice.label
    end

    context "in Tableau" do
      it_should_write 'Prestation'
      it_should_write 'Prix'
      it_should_write 'unitaire'
      it_should_write 'Quantité'
      it_should_write 'Total HT'


      context "in Lignes de facturation" do
        it 'should write invoice line label of each invoice line' do
          invoice.lines.each do |line|
            text.strings.should include line.label
          end
        end

        it 'should write invoice line unit_price of each line' do
          text.strings.should include '2,00'
          text.strings.should include '400,00'
        end

        it 'should write invoice quantity of each line' do
          text.strings.should include '4,0'
          text.strings.should include '43,5'
        end

        it 'should write invoice line total of each line' do
          text.strings.should include '10,99'
          text.strings.should include '1600,00'
        end
      end # context in Lignes de facturation

      context 'in Synthèse' do
        it_should_write 'Net HT'
        it_should_write '1000,00 €'

        it_should_write 'TVA 19,6 %'
        it_should_write '196,00 €'

        it_should_write 'Total TTC'
        it_should_write '1196,00 €'

        it_should_write 'Acompte reçu sur commande'
        it_should_write '50,00 €'

        it_should_write 'Solde à payer'
        it_should_write '1146,00 €'
      end
    end # context in Tableau
    it_should_write 'Conditions de paiement :'

    it 'should write invoice payment term' do
      text.strings.should include invoice.payment_term.label
    end

    it_should_write 'Coordonnées bancaires :'
    it_should_write 'IBAN : ***REMOVED***'
    it_should_write 'BIC / SWIFT : ***REMOVED***'

    context 'in Mentions légales - Bas de page' do
        it_should_write 'Mention légale'
        it_should_write 'Tout retard de règlement donnera lieu de plein droit et sans qu’aucune mise en demeure ne soit nécessaire au paiement de'
        it_should_write 'pénalités de retard sur la base du taux BCE majoré de dix (10) points et au paiement d’une indemnité forfaitaire pour frais de'
        it_should_write 'recouvrement d’un montant de 40€'
    end


  end # describe #build
end

# encoding: utf-8
require 'spec_helper'

describe SudDeveloppementInvoice, pdfs: true do

  def self.it_should_write(string, failure_message = nil)
    it "should write '#{string}'  " do
      text.strings.should include(string), failure_message
    end
  end

  let(:customer) { FactoryGirl.create(:customer, city: 'Mickey City', address2: 'address2 value') }

  let(:id_card) { FactoryGirl.create(:id_card,
    contact_phone: '+33 (0)6 00 00 00 00',
    contact_email: 'email@example.org',
    contact_address_1: 'BP00',
    contact_zip: '83000',
    contact_city: 'Some City',
    address1: '42 Avenue de Ruby',
    zip: '83100',
    city: 'Some Long City Name',
    legal_form: 'SA',
    capital: 100_000,
    registration_city: "RCS à NICE",
    registration_number: 'A 000 000 000',
    siret: '000 000 000 00000',
    bank_name: 'BANK NAME',
    iban: 'FR76 0000 0000 0000 0000 0000 000',
    bic_swift: 'PSSTTHEGAME',
    bank_address: 'Office City (Some Zip)',
    custom_info_1: 'The Company INSERT THE NAME' + "\n" + 'declares bla bla bla bla bla bla' + "\n" + 'bla bla bla bla bla bla bla bla bla',
    custom_info_2: 'Carte Professionnelle Transactions N°0000 Préfecture TOULON Var (83)',
    custom_info_3: 'RC PRO Blablablabla N° 000 000 000 000'
  ) }

  let(:invoice) { FactoryGirl.create(:invoice,
      id_card: id_card,
      customer: customer,
      total_duty: 54.36,
      vat: 10.65,
      total_all_taxes: 65.01,
      advance: 1.34,
      vat_rate: 19.6) }

  let(:invoice_line) { FactoryGirl.create(:invoice_line,
    invoice_id: invoice.id,
    quantity: 3.14,
    unit: 'heures',
    unit_price: 2.54,
    total: 10.99) }

  let(:invoice_line_2) { FactoryGirl.create(:invoice_line,
    invoice_id: invoice.id,
    label: 'Truc',
    quantity: 42.42,
    unit: 'nuts',
    unit_price: 42.54,
    total: 561.99) }

  let(:pdf) { FactoryGirl.build(:sud_developpement_invoice, invoice: invoice) }

  describe "#initialize" do
    it 'inherits from Prawn::Document' do
      pdf.should be_kind_of(Prawn::Document)
    end

    it 'should assign @invoice' do
      pdf.invoice.should eq(invoice)
    end
  end

  describe '#build' do
    let(:text) { PDF::Inspector::Text.analyze(pdf.render) }
    before do
      invoice.lines << invoice_line
      invoice.lines << invoice_line_2
      pdf.build
    end

    it_should_write 'FACTURE'

    context 'in Mentions légales - Colonne de gauche' do
      it_should_write 'Téléphone'
      it_should_write '+33 (0)6 00 00 00 00'
      it_should_write 'mail à'
      it_should_write 'email@example.org'
      it_should_write 'Courrier à'
      it_should_write 'BP00'
      it_should_write '83000'
      it_should_write 'Some City'

      it_should_write 'SA au capital de'
      it_should_write '100 000 euros'
      it_should_write 'RCS à NICE'
      it_should_write 'A 000 000 000'
      it_should_write 'SIRET'
      it_should_write '000 000 000 00000'
      it_should_write 'APE/NAF 6831Z'
      it_should_write 'Carte Professionnelle'
      it_should_write 'Transactions N°0000'
      it_should_write 'Préfecture TOULON'
      it_should_write 'Var (83)'
      it_should_write 'RC PRO Blablablabla'
      it_should_write 'N° 000 000 000 000'
      it_should_write 'Siège Social à'
      it_should_write '42 Avenue de Ruby'
      it_should_write '83100'

      # SAINT CYR SUR MER is written on two lines and needs two assertions
      it "should write 'SAINT CYR SUR MER'" do
        text.strings.should include 'Some Long City'
        text.strings.should include 'Name'
      end

    end # context in Mentions légales - Colonne de gauche

    context 'in Déclaration' do # written on 3 lines and needs 3 assertions
      it_should_write 'The Company INSERT THE NAME'
      it_should_write 'declares bla bla bla bla bla bla'
      it_should_write 'bla bla bla bla bla bla bla bla bla'
    end

    context 'in Informations client' do

      # WARNING there are 2 occurrences of customer name so this test
      # is incomplete
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
    end

    context 'in Entete de facturation' do
      it_should_write 'FACTURE N°'


      # WARNING there are 2 occurrences of invoice tracking id so this test
      # is incomplete
      it "should write invoice tracking id" do
        text.strings.should include invoice.tracking_id
      end

      it_should_write 'Date'
      it 'should write invoice date' do
        text.strings.should include invoice.date.strftime("%d/%m/%Y")
      end

      it_should_write 'LIBELLES'
      it_should_write 'Q'
      it_should_write 'U'
      it_should_write 'PU'
      it_should_write 'MONTANT'
    end

    context 'in Lignes de facturation and Synthèse' do
      it 'should write invoice line label of each invoice line' do
        invoice.lines.each do |line|
          text.strings.should include line.label
        end
      end

      it 'should write invoice line unit of each invoice line' do
        invoice.lines.each do |line|
          text.strings.should include line.unit
        end
      end

      context 'with floating values in french syntax' do
        it 'should write invoice line quantity of each line' do
          text.strings.should include '3,14'
          text.strings.should include '42,42'
        end

        it 'should write invoice line unit_price of each line' do
          text.strings.should include '2,54 €'
          text.strings.should include '42,54 €'
        end

        it 'should write invoice line total of each line' do
          text.strings.should include '10,99 €'
          text.strings.should include '561,99 €'
        end

        it_should_write 'TOTAL HT'
        it_should_write '54,36 €'

        it_should_write 'TVA (19,6%)'
        it_should_write '10,65 €'

        it_should_write 'TOTAL TTC'
        it_should_write '65,01 €'

        it_should_write 'Acompte reçu sur commande'
        it_should_write '1,34 €'

        it_should_write 'Solde à payer'
        it 'should write balance calculated using total_all_taxes - advance' do
          text.strings.should include '63,67 €'
        end

      end # context with floating values in french syntax

      it 'should write invoice payment term' do
        text.strings.should include invoice.payment_term.label
      end

      it_should_write 'Banque : BANK NAME'
      it_should_write 'Agence de : Office City (Some Zip)'
      it_should_write 'IBAN : FR76 0000 0000 0000 0000 0000 000'
      it_should_write 'BIC : PSSTTHEGAME'
    end # context in Lignes de facturation and Synthèse

    context 'in Pied de page' do
      it 'should write invoice FACTURE + invoice tracking_id + customer name' do
        text.strings.should include 'FACTURE' + ' ' + invoice.tracking_id +
          '  ' + invoice.customer.name
      end

      it_should_write 'Page 1 / 1'
    end

  end # describe #build
end

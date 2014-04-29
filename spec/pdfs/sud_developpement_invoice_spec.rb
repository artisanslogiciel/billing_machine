require 'spec_helper'

describe SudDeveloppementInvoice, pdfs: true do
  let(:invoice) { FactoryGirl.create(:invoice) }
  let(:invoice_line) { FactoryGirl.create(:invoice_line) }
  let(:invoice_line_2) { FactoryGirl.create(:invoice_line_2) }
  let(:pdf) { SudDeveloppementInvoice.new(invoice) }

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
      it_should_write '+33 (0)6 62 15 80 90'
      it_should_write 'mail à'
      it_should_write 'jogallien@sud-d.com'
      it_should_write 'Courrier à'
      it_should_write 'BP17'
      
      # WARNING there are 2 occurrences of 83270 so this test is incomplete
      it_should_write '83270'
      
      it_should_write 'ST-CYR SUR MER'
      it_should_write 'SARL au capital de'
      it_should_write '1 000 euros'
      it_should_write 'RCS à TOULON'
      it_should_write 'B 753 162 213'
      it_should_write 'SIRET'
      it_should_write '753 162 213 00015'
      it_should_write 'APE/NAF 6831Z'
      it_should_write 'Carte Professionnelle'
      it_should_write 'Transactions N°5956'
      it_should_write 'Préfecture TOULON'
      it_should_write 'Var (83)'
      it_should_write 'RC PRO Groupama'
      it_should_write 'N° 500 407 450 001'
      it_should_write 'Siège Social à'
      it_should_write 'Ch. du Collet-Redon'
      it_should_write '83270'
      
      # SAINT CYR SUR MER is written on two lines and needs two assertions
      it "should write 'SAINT CYR SUR MER'" do
        text.strings.should include 'SAINT CYR SUR'
        text.strings.should include 'MER'
      end
      
    end # context in Mentions légales - Colonne de gauche

    context 'in Déclaration' do
      it_should_write 'La société SUD-DÉVELOPPEMENT'
      it_should_write 'déclare ne recevoir ni ne détenir'
      it_should_write 'aucun fonds, effets ou valeurs'
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
        before do
          invoice_line.quantity = 3.14
          invoice_line_2.quantity = 42.42
          invoice_line.unit_price = 2.54
          invoice_line_2.unit_price = 42.54
          invoice_line.total = 10.99
          invoice_line_2.total = 561.99
          invoice.total_duty = 54.36
          invoice.vat = 34.99
          invoice.total_all_taxes = 54.39
          invoice.advance = 1.34
          invoice.balance = 11.59
          pdf.build
        end
      
        it 'should write invoice line quantity of each line' do
          text.strings.should include '3,14'
          text.strings.should include '42,42'
        end
        
        it 'should write invoice line unit_price of each line' do
          text.strings.should include '2,54 €'
          text.strings.should include '42,54 €'
        end
       
        it 'should write invoice line total of each line' do
          text.strings.should include('10,99 €'), 'see factory for input value'
          text.strings.should include('561,99 €'), 'see factory for input value'
        end
  
        it_should_write 'TOTAL HT'
        it_should_write '54,36 €', 'see factory for input value'
        
        it_should_write 'TVA (20,00%)'
        it_should_write '34,99 €', 'see factory for input value'
  
        it_should_write 'TOTAL TTC'
        it_should_write '54,39 €', 'see factory for input value'
  
        it_should_write 'Acompte reçu sur commande'
        it_should_write '1,34 €', 'see factory for input value'
  
        it_should_write 'Solde à payer'
        it_should_write '11,59 €', 'see factory for input value'
      end # context with floating values in french syntax
      
      it_should_write 'Banque : BNP PARIBAS'
      it_should_write 'Agence de : SAINT CYR SUR MER (83270)'
      it_should_write 'IBAN : ***REMOVED***'
      it_should_write 'BIC : ***REMOVED***'
    end # context in Lignes de facturation and Synthèse
    
    context 'in Pied de page' do
      it_should_write 'FACTURE'
      it_should_write 'Page 1 / 1'
    end
      
  end # describe #build  
end
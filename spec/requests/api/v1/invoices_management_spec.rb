require 'spec_helper'
require 'json'

describe 'Invoices management' do
  before(:each) do
    @invoice = FactoryGirl.create(:invoice)
    @invoice_line = FactoryGirl.create(:invoice_line, invoice: @invoice)
  end

  context 'when not authenticated' do
    describe '#index' do
      it 'refuses access' do
        get '/api/v1/invoices'
        expect(response.status).to_not eq(200)
      end
    end
  end

  context 'when authenticated' do
    before(:each) do
      sign_in_as_a_valid_user
    end
    describe '#index' do
      it 'returns all items' do
        get '/api/v1/invoices'

        expect(json.size).to eq(1)
        expect(json[0]['id']).to eq(@invoice.id)
      end
    end

    def check_show json, invoice
        expect(json['id']).to eq(invoice.id)
        expect(json['label']).to eq(invoice.label)
        expect(json['date']).to eq(invoice.date.to_s(:db))
        expect(json['customer_id']).to eq(invoice.customer_id)
        expect(json['total_duty']).to eq(invoice.total_duty)
        expect(json['vat']).to eq(invoice.vat)
        expect(json['total_all_taxes']).to eq(invoice.total_all_taxes)
        expect(json['advance']).to eq(invoice.advance)
        expect(json['balance']).to eq(invoice.balance)
        expect(json['payment_term_id']).to eq(invoice.payment_term_id)
        
        expect(json['lines_attributes'][0]['id']).to eq(invoice.lines[0].id)
        expect(json['lines_attributes'][0]['label']).to eq(invoice.lines[0].label)
        expect(json['lines_attributes'][0]['quantity']).to eq(invoice.lines[0].quantity)
        expect(json['lines_attributes'][0]['unit']).to eq(invoice.lines[0].unit.to_s)
        expect(json['lines_attributes'][0]['unit_price']).to eq(invoice.lines[0].unit_price)
        expect(json['lines_attributes'][0]['total']).to eq(invoice.lines[0].total)
     end

    describe '#show' do
      it 'returns the item' do
        get "/api/v1/invoices/#{@invoice.id}"
        check_show json, @invoice
      end
    end
    
    describe '#create' do
      it 'returns the newly created item' do
        post '/api/v1/invoices', invoice: FactoryGirl.attributes_for(:invoice).merge({ lines_attributes: [FactoryGirl.attributes_for(:invoice_line)]})
        invoice = Invoice.last
        check_show json, invoice   
      end
    end

    describe '#update' do
      it 'returns the updated item' do
        new_label = @invoice.label + " modified"

        put "/api/v1/invoices/#{@invoice.id}", invoice: { label: new_label }

        expect(json['label']).to eq(new_label)
      end
    end
  end
end

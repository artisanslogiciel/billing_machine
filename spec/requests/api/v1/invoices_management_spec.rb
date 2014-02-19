require 'spec_helper'
require 'json'

describe 'Invoices management' do
  before(:each) do
    @invoice = FactoryGirl.create(:invoice)
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

    describe '#create' do
      it 'returns the newly created item' do
        post '/api/v1/invoices', invoice: FactoryGirl.attributes_for(:invoice)

        invoice = Invoice.last
        expect(json['id']).to eq(invoice.id)
        expect(json['label']).to eq(invoice.label)
        expect(json['date']).to eq(invoice.date.to_s(:db))
        expect(json['total_duty']).to eq(invoice.total_duty.to_s)
        expect(json['vat']).to eq(invoice.vat.to_s)
        expect(json['total_all_taxes']).to eq(invoice.total_all_taxes.to_s)
        expect(json['advance']).to eq(invoice.advance.to_s)
        expect(json['balance']).to eq(invoice.balance.to_s)
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

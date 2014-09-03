require 'spec_helper'

describe InvoicesController do
  let(:user) { FactoryGirl.create :user }
  let(:id_card) { FactoryGirl.create(:id_card, entity: user.entity) }
  let(:invoice) { FactoryGirl.create(:invoice, id_card: id_card) }
  let(:another_invoice) { FactoryGirl.create(:invoice) }

  context 'when not authenticated' do
    describe '#index' do
      it 'should refuse access' do
        get :index
        response.status.should_not eq(200)
      end
    end
   describe '#show' do
      it 'should refuse access' do
        get :show, id: invoice.id, format: :pdf
        response.status.should_not eq(200)
      end
    end
  end

  context 'when authenticated' do
    before(:each) do
      sign_in user
    end

    describe '#index' do
      it 'should grant access' do
        get :index
        response.status.should eq(200)
      end
    end
    describe '#show' do
      it 'should grant access' do
        get :show, id: invoice.id, format: :pdf
        response.status.should eq(200)
      end
      it 'should assign @invoice' do
        get :show, id: invoice.id, format: :pdf
        assigns(:invoice).should eq(invoice)
      end
      it 'should ensure that user is authorized to access it' do
        get :show, id: another_invoice.id, format: :pdf
        response.should redirect_to root_url
      end
    end
  end
end

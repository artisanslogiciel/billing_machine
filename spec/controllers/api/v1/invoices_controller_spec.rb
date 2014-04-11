require 'spec_helper'

module Api
  module V1
    describe InvoicesController do
      context 'when not authenticated' do
        describe '#index' do
          it 'should refuse access' do
            get :index
            response.status.should_not eq(200)
          end
        end
        describe '#create' do
          it 'should refuse access' do
            post :create, format: :json, invoice: FactoryGirl.attributes_for(:invoice)
            response.status.should_not eq(200)
          end
        end
      end

      context 'when authenticated' do
        let(:user) {FactoryGirl.create :user }
        let(:invoice) { FactoryGirl.create(:invoice, entity: user.entity) }
        let(:another_invoice) { FactoryGirl.create(:invoice) }

        before(:each) do
          sign_in user
        end

        
        describe '#index' do
          it 'should grant access' do
            get :index, format: :json
            response.status.should eq(200)
          end

          it 'should check access rights' do
            user.update(billing_machine: false)
            expect {
              get :index, format: :json
              }.to raise_exception CanCan::AccessDenied       
          end

          it 'should return invoices' do
            invoice = FactoryGirl.create(:invoice, entity: user.entity)
            another_invoice = FactoryGirl.create(:invoice)
            get :index, format: :json
            assigns(:invoices).should eq([invoice])
          end
        end

        describe '#create' do
          it 'should create an entry with valid params' do
            post :create, format: :json, invoice: FactoryGirl.attributes_for(:invoice)
            response.status.should eq(200)
          end
          it 'should assign entity_id' do
            post :create, format: :json, invoice: FactoryGirl.attributes_for(:invoice)
            assigns(:invoice).entity_id.should eq(user.entity_id)
          end
          it 'should return an error code when it cannot save the entity' do
            Invoice.any_instance.stub(:save).and_return false
            post :create, format: :json, invoice: { name: '' }
            response.status.should eq(422)
          end
          it 'should check access rights' do
            user.update(billing_machine: false)
            expect {
              post :create, format: :json, invoice: FactoryGirl.attributes_for(:invoice)
              }.to raise_exception CanCan::AccessDenied       
          end

         end

        describe '#update' do

          it 'should check access rights' do
            expect {
              put :update, id: another_invoice.id, format: :json, invoice: { label: 'Updated' }
              }.to raise_exception CanCan::AccessDenied       
          end

          it 'should update an entry with valid params' do
            put :update, id: invoice.id, format: :json, invoice: { label: 'Updated' + invoice.label }
            response.status.should eq(200)
          end

          it 'should return an error code when it cannot save the entity' do
            Invoice.any_instance.stub(:save).and_return false
            put :update, id: invoice.id, format: :json, invoice: { label: 'Updated' + invoice.label }
            response.status.should eq(422)
          end
        end
        
        describe '#show' do
          it 'should check access rights' do
            expect {
              get :show, id: another_invoice.id, format: :json
              }.to raise_exception CanCan::AccessDenied       
          end

          it 'should check access rights' do
            get :show, id: invoice.id, format: :json
            response.status.should eq(200)     
          end

        end
      end
    end
  end
end

require 'spec_helper'

module Api
  module V1
    describe InvoicesController do
      JSON_RESPONSE_403 = '{"error":"You don\'t have access to this functionality"}'
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
        let!(:id_card) { FactoryGirl.create(:id_card, entity: user.entity) }
        let(:invoice) { FactoryGirl.create(:invoice, id_card: id_card) }
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
            get :index, format: :json

            assert_response :forbidden
            response.body.should == JSON_RESPONSE_403
          end

          it 'should return invoices in JSON of the current user.entity' do
            invoice_from_other_entity = FactoryGirl.create(:invoice)
            get :index, format: :json
            assigns(:invoices).should eq([invoice])
          end

          it 'should respond in CSV' do
            get :index, format: :csv
            assert_response :success
          end

          it 'should return invoices in CSV of the current user.entity' do
            another_invoice = FactoryGirl.create(:invoice)
            get :index, format: :csv
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
            assigns(:invoice).entity.should eq(user.entity)
          end
          it 'should return an error code when it cannot save the entity' do
            Invoice.any_instance.stub(:save).and_return false
            post :create, format: :json, invoice: { name: '' }
            response.status.should eq(422)
          end
          it 'should check access rights' do
            user.update(billing_machine: false)
            post :create, format: :json, invoice: FactoryGirl.attributes_for(:invoice)

            assert_response :forbidden
            response.body.should == JSON_RESPONSE_403
          end

        end

        describe '#update' do

          it 'should check access rights' do
            put :update, id: another_invoice.id, format: :json, invoice: { label: 'Updated' }

            assert_response :forbidden
            response.body.should == JSON_RESPONSE_403
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
            get :show, id: another_invoice.id, format: :json

            assert_response :forbidden
            response.body.should == JSON_RESPONSE_403
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

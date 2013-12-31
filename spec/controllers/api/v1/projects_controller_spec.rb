require 'spec_helper'

module Api
  module V1
    describe ProjectsController do
      context 'when not authenticated' do
        describe '#index' do
          it 'should refuse access' do
            get :index
            response.status.should_not eq(200)
          end
        end
        describe '#create' do
          it 'should refuse access' do
            post :create, format: :json, project: FactoryGirl.attributes_for(:project)
            response.status.should_not eq(200)
          end
        end
      end

      context 'when authenticated' do
        before(:each) do
          sign_in FactoryGirl.create :user
        end

        describe '#index' do
          it 'should grant access' do
            get :index, format: :json
            response.status.should eq(200)
          end

          it 'should sort projects by name' do
            project_0 = FactoryGirl.create(:project, name: 'Charle')
            project_1 = FactoryGirl.create(:project, name: 'Alice')
            project_2 = FactoryGirl.create(:project, name: 'Bob')
            get :index, format: :json
            assigns(:projects).should eq([project_1, project_2, project_0])

          end
        end

        describe '#create' do
          it 'should create an entry with valid params' do
            post :create, format: :json, project: FactoryGirl.attributes_for(:project)
            response.status.should eq(200)
          end
          it 'should return an error code when it cannot save the entity' do
            post :create, format: :json, project: { name: '' }
            response.status.should eq(422)
          end
        end

        describe '#update' do
          let(:project) { FactoryGirl.create(:project) }

          it 'should update an entry with valid params' do
            put :update, id: project.id, format: :json, project: { name: 'Updated' + project.name }
            response.status.should eq(200)
          end

          it 'should return an error code when it cannot save the entity' do
            put :update, id: project.id, format: :json, project: { name: '' }
            response.status.should eq(422)
          end
        end
      end
    end
  end
end

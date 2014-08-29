require 'spec_helper'

describe Entity do
  it 'should have a valid factory' do
    FactoryGirl.build(:entity).should be_valid
  end
  it { should have_many :invoices }
  it { should have_many :payment_terms }
  it { should have_many :customers }
  it { should respond_to :customization_prefix }
  it { should validate_presence_of :customization_prefix }

  it { should respond_to :current_id_card }

  describe 'current_id_card' do
    it 'should the current id card' do
      entity = FactoryGirl.create(:entity)

      id_card_1 = FactoryGirl.create(:id_card, entity: entity)
      id_card_2 = FactoryGirl.create(:id_card, entity: entity)
      id_card_3 = FactoryGirl.create(:id_card, entity: entity)
      entity.current_id_card_id = id_card_2.id
      entity.save
      entity.reload.current_id_card.should eq(id_card_2)
    end

  end
end

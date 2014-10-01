require 'spec_helper'

describe IdCard do
  it 'should have a valid factory' do
    FactoryGirl.build(:id_card).should be_valid
  end

  it { should validate_presence_of :entity }
  it { should have_many :invoices }

  it { should have_attached_file(:logo) }
  it { should validate_attachment_content_type(:logo).
                  allowing('image/png','image/jpeg', 'image/gif').
                  rejecting('text/plain', 'text/xml','image/svg') }

  it 'should add itself as current id card upon creation' do
    e = FactoryGirl.create(:entity)
    card = FactoryGirl.create(:id_card, entity: e)
    e.reload.current_id_card_id.should eq(card.id)
  end

end

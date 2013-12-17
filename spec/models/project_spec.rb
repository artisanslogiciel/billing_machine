require 'spec_helper'

describe Project do
  it 'should have a valid factory' do
    expect(FactoryGirl.build(:project)).to be_valid
  end
    it { should validate_presence_of :name }
  it { should ensure_length_of(:name).is_at_least(3) }
end

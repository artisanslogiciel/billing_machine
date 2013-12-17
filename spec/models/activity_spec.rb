require 'spec_helper'

describe Activity do
  it 'should have a valide factory' do
    expect(FactoryGirl.build(:activity)).to be_valid
  end

  it { should validate_presence_of :label }
  it { should ensure_length_of(:label).is_at_least(3) }
end

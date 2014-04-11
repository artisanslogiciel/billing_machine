require 'spec_helper'

describe TimeSlice do
  it 'should have a valide factory' do
    expect(FactoryGirl.build(:time_slice)).to be_valid
  end

  it { should belong_to :project }
  it { should belong_to :user }
  it { should belong_to :activity }
  it { should validate_presence_of :duration }
  it { should validate_numericality_of(:duration).is_greater_than(0).is_less_than(12) }
end

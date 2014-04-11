require 'spec_helper'

describe User do
  it 'should have a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  it {should belong_to :entity}
  it {should have_many :time_slices}
end

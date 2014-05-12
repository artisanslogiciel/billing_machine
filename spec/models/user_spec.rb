require 'spec_helper'

describe User do
  it 'should have a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  it {should belong_to :entity}
  it {should have_many :time_slices}

  it 'should not be manager by default' do
    user = FactoryGirl.build(:user)
    user.should_not be_manager
  end

  it 'should be manager when having a manager_id' do
    user = FactoryGirl.build(:user, manager_id: 1)
    user.should be_manager
  end

end

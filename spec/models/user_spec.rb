require 'spec_helper'

describe User do
  it 'should have a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  it {should belong_to :entity}
  it {should have_many :time_slices}

  it 'should not be manager by default' do
    user = FactoryGirl.build(:user)
    user.manager_id.should be nil
  end

  it 'should not be administrator by default' do
    user = FactoryGirl.build(:user)
    user.should_not be_administrator
  end

  it 'should be administrator when bulding an admin user' do
    user = FactoryGirl.build(:admin_user)
    user.should be_administrator
  end

end

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

  describe '#to_csv' do
    let(:user) { FactoryGirl.create(:user) }
    it 'should return expected csv' do
      slice0 = FactoryGirl.create(:time_slice, day: Date.new(2013, 10, 1), user: user)
      slice1 = FactoryGirl.create(:time_slice, day: Date.new(2013,  9, 1), user: user, comment: nil)
      slice2 = FactoryGirl.create(:time_slice, day: Date.new(2013, 11, 1), user: user)
      TimeSlice.to_csv.should be ==
        "Date;Project;Duration;Activity;Comment\n"+
        "2013-10-01;#{slice0.project.name};#{slice0.duration};#{slice0.activity.label};#{slice0.comment}\n"+
        "2013-09-01;#{slice1.project.name};#{slice1.duration};#{slice1.activity.label};#{slice1.comment}\n"+
        "2013-11-01;#{slice2.project.name};#{slice2.duration};#{slice2.activity.label};#{slice2.comment}\n"
    end
  end
end

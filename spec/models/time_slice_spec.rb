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

  it 'should validate date' do
    expect { FactoryGirl.create(:time_slice, day: 'I\'m not a date') }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe '#to_csv' do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project, name: "projectName") }
    let(:activity) { FactoryGirl.create(:activity, label: "activityLabel") }
    let(:columns_names) {"Date;Project;Duration;Activity;Comment;Billing\n"}

    it 'should return expected csv' do
      slice0 = FactoryGirl.create(:time_slice, day: '2013-10-01', comment: "SliceComment", duration: "3.14",
        user: user, project: project, activity: activity)
      slice0.dup.update(day: '2013-09-01', billable: true) # copy first slice to
      slice0.dup.update(day: '2013-11-01', comment: nil) # factorize arguments
      TimeSlice.to_csv.should be ==
        columns_names +
        "2013-10-01;projectName;3.14;activityLabel;SliceComment;false\n"+
        "2013-09-01;projectName;3.14;activityLabel;SliceComment;true\n"+
        "2013-11-01;projectName;3.14;activityLabel;;false\n"
    end

    it 'should return expected csv with nil values' do
      slice0 = TimeSlice.create(duration: 1, day: '1970-01-01', user: user)
      TimeSlice.to_csv.should be ==
        columns_names +
        "1970-01-01;;#{slice0.duration};;;false\n"
    end
  end
end

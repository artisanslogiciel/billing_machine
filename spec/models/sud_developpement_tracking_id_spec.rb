require 'spec_helper'
describe SudDeveloppementTrackingId do
  describe 'get_tracking_id' do

    it 'should return correct tracking_id for sud_developpement' do
      date = Date.parse('2014-02-01')
      SudDeveloppementTrackingId.get_tracking_id(date, unique_index=69).should eq('20140201-69')
    end

    it 'should return correct tracking_id for sud_developpement when no date for invoice' do
      SudDeveloppementTrackingId.get_tracking_id(date=nil, unique_index=46).should eq('46')
    end

  end
end

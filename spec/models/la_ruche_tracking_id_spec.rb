require 'spec_helper'
describe LaRucheTrackingId do
  describe 'get_tracking_id' do

    it 'should return correct tracking_id for laruche' do
      date = Date.parse('2013-05-20')
      LaRucheTrackingId.get_tracking_id(date, unique_index=37).should eq('13-37')
    end
    it 'should return correct tracking_id for laruche' do
      date = Date.parse('2014-05-20')
      LaRucheTrackingId.get_tracking_id(date, unique_index=142).should eq('14-142')
    end
    it 'should return correct tracking_id for laruche' do
      date = Date.parse('2010-05-20')
      LaRucheTrackingId.get_tracking_id(date, unique_index=9).should eq('10-09')
    end
    it 'should return correct tracking_id for laruche' do
      date = Date.parse('2010-05-20')
      LaRucheTrackingId.get_tracking_id(date, unique_index=10).should eq('10-10')
    end
    it 'should return correct tracking_id for laruche' do
      date = Date.parse('2010-05-20')
      LaRucheTrackingId.get_tracking_id(date, unique_index=1).should eq('10-01')
    end
    it 'should return correct tracking_id for laruche' do
      date = Date.parse('2010-05-20')
      LaRucheTrackingId.get_tracking_id(date, unique_index=1).should eq('10-01')
    end
    it 'should return correct tracking_id for laruche when no date for invoice' do
      LaRucheTrackingId.get_tracking_id(date=nil, unique_index=666).should eq('666')
    end

  end
end

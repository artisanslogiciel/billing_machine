require 'spec_helper'
describe AgilideeTrackingId do
  describe 'get_tracking_id' do

    it 'should return correct tracking_id for agilidee' do
      date = Date.parse('2013-05-20')
      AgilideeTrackingId.get_tracking_id(date, unique_index=37).should eq('1337')
    end
    it 'should return correct tracking_id for agilidee' do
      date = Date.parse('2014-05-20')
      AgilideeTrackingId.get_tracking_id(date, unique_index=142).should eq('14142')
    end
    it 'should return correct tracking_id for agilidee' do
      date = Date.parse('2010-05-20')
      AgilideeTrackingId.get_tracking_id(date, unique_index=9).should eq('1009')
    end
    it 'should return correct tracking_id for agilidee' do
      date = Date.parse('2010-05-20')
      AgilideeTrackingId.get_tracking_id(date, unique_index=10).should eq('1010')
    end
    it 'should return correct tracking_id for agilidee' do
      date = Date.parse('2010-05-20')
      AgilideeTrackingId.get_tracking_id(date, unique_index=1).should eq('1001')
    end
    it 'should return correct tracking_id for agilidee' do
      date = Date.parse('2010-05-20')
      AgilideeTrackingId.get_tracking_id(date, unique_index=1).should eq('1001')
    end
    it 'should return correct tracking_id for agilidee when no date for invoice' do
      AgilideeTrackingId.get_tracking_id(date=nil, unique_index=666).should eq('666')
    end

  end
end

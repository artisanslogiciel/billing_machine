require 'spec_helper'

describe InvoiceLine do
  it 'should have a valid factory' do
    FactoryGirl.build(:invoice_line).should be_valid
  end
  it { should belong_to :invoice }
  it 'should be sorted by created_at' do
    line1 = FactoryGirl.create(:invoice_line,:created_at => DateTime.now + 1.seconds)
    line2 = FactoryGirl.create(:invoice_line,:created_at => DateTime.now + 2.seconds)
    line3 = FactoryGirl.create(:invoice_line,:created_at => DateTime.now + 3.seconds)
    line4 = FactoryGirl.create(:invoice_line,:created_at => DateTime.now + 4.seconds)
    line3.update(:created_at => DateTime.now+5.seconds)
    lines = InvoiceLine.all
    lines.should == ([line1, line2, line4, line3])
  end
end

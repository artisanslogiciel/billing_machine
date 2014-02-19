require 'spec_helper'

describe InvoiceLine do
  it 'should have a valid factory' do
    FactoryGirl.build(:invoice_line).should be_valid
  end
  it { should belong_to :invoice }
end

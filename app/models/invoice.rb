class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :payment_term
  belongs_to :entity
  has_many :lines,  inverse_of: :invoice, dependent: :destroy, class_name: 'InvoiceLine'
  accepts_nested_attributes_for :lines, allow_destroy: true
  validates_presence_of :entity
  before_create :assign_unique_index

  def assign_unique_index
    entity.unique_index += 1
    entity.save
    self.unique_index = entity.unique_index
  end

  def tracking_id
    if self.date
      "#{self.date.strftime("%Y%m%d")}-#{self.unique_index}" 
    else
      self.unique_index 
    end
  end

end

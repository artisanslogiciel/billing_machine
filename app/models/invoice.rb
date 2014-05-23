class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :payment_term
  belongs_to :entity, inverse_of: :invoices
  has_many :lines,  inverse_of: :invoice, dependent: :destroy, class_name: 'InvoiceLine'
  accepts_nested_attributes_for :lines, allow_destroy: true
  validates_presence_of :entity
  before_create :assign_unique_index

  before_save :update_balance

  def assign_unique_index
    entity.unique_index ? entity.unique_index += 1 : entity.unique_index = 1
    entity.save
    self.unique_index = entity.unique_index
  end

  def tracking_id
    id_generator_class_name = (self.entity.customization_prefix + "_tracking_id").camelize
    id_generator_class = id_generator_class_name.constantize
    tracking_id = id_generator_class.get_tracking_id(self.date, self.unique_index)
    return tracking_id
  end

  def update_balance
    #self.advance ||= total_all_taxes
    self.advance ||= 0
    self.balance = self.total_all_taxes - self.advance
  end

  def pdf
    klass = (self.entity.customization_prefix + "_invoice").camelize.constantize
    pdf = klass.new(self)
    pdf.build
    return pdf
  end
end

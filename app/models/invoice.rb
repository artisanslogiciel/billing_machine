# encoding: utf-8
class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :payment_term
  belongs_to :id_card, inverse_of: :invoices , dependent: :destroy
  delegate :entity, to: :id_card
  has_many :lines,  inverse_of: :invoice, dependent: :destroy, class_name: 'InvoiceLine'
  accepts_nested_attributes_for :lines, allow_destroy: true
  validates_presence_of :id_card
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

  def self.to_csv(options = { :force_quotes => true, :col_sep => ";" })
    CSV.generate(options) do |csv|
      column_names = ["Date", "Numéro", "Objet", "Client", "Adresse 1", "Adresse 2",
        "Code postal", "Ville", "Pays", "Montant HT", "Taux TVA", "Montant TVA",
        "Montant TTC", "Acompte", "Solde à payer"]
      csv << column_names
      all.each do |invoice|
        csv <<  [invoice.date,
                 invoice.tracking_id,
                 invoice.label,
                 invoice.customer.try(:name),
                 invoice.customer.try(:address1),
                 invoice.customer.try(:address2),
                 invoice.customer.try(:zip),
                 invoice.customer.try(:city),
                 invoice.customer.try(:country),
                 french_number(invoice.total_duty),
                 french_number(invoice.vat_rate),
                 french_number(invoice.vat),
                 french_number(invoice.total_all_taxes),
                 french_number(invoice.advance),
                 french_number(invoice.balance)]
      end
    end
  end
  def self.french_number amount
     extend ActionView::Helpers::NumberHelper
     number_with_delimiter(amount, :delimiter => '', :separator => ",")
  end
end

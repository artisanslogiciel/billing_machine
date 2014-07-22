class IdCard < ActiveRecord::Base
  belongs_to :entity, inverse_of: :id_cards
  has_many :invoices, inverse_of: :id_card
  validates_presence_of :entity

  has_attached_file :logo
  # exclude SVG until the pdf generator can use it, issue #171
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/,
                                           :not => "image/svg"

end

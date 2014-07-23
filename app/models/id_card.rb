class IdCard < ActiveRecord::Base
  belongs_to :entity, inverse_of: :id_cards
  has_many :invoices, inverse_of: :id_card
  validates_presence_of :entity
  #validates_presence_of :id_card_name TODO: make it work, model is screwed, see Invoice

  has_attached_file :logo,
    :styles => { :large => "1000x1000>", :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "/images/no_logo.png"
  # exclude SVG until the pdf generator can use it, issue #171
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/,
                                           :not => "image/svg"

end

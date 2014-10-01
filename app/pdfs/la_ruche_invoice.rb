# encoding: utf-8

class LaRucheInvoice < Prawn::Document
  include ActionView::Helpers::NumberHelper
  attr_accessor :invoice

  GREY = "808080"
  LIGHT_GREY = "C0C0C0"
  WHITE = "FFFFFF"
  DEBUG = true
  FRENCH_MONTH_NAMES = [nil, 'janvier', 'février', 'mars', 'avril', 'mai',
    'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']

  def initialize(invoice)
    super(:page_size => 'A4')
    @invoice = invoice
    @id_card = invoice.id_card
  end

  def build
    if @invoice.id_card.logo.exists?
      image @invoice.id_card.logo.path , at: [55, 735], :width => 150
    end

    # Slogan
    bounding_box [50, 650], :width => 420, :height => 50 do
      draw_bounds_debug
      font_size 12
      text @id_card.custom_info_1
    end

    # Mentions légales - Coin supérieur droit
    bounding_box [235, 735], :width => 235, :height => 75 do
      draw_bounds_debug
      font_size 8
      write_legal_line 'SIRET ' + @id_card.siret.to_s + ' APE ' + @id_card.ape_naf.to_s
      write_legal_line @id_card.legal_form.to_s
      write_legal_line @id_card.registration_city.to_s + ' ' + @id_card.registration_number.to_s
      move_down 15
      write_legal_line @id_card.address1.to_s
      write_legal_line @id_card.zip.to_s + " " + @id_card.city.to_s
    end

    # Entete de facturation
    bounding_box [300, 585], :width => 170, :height => 50 do
      draw_bounds_debug
      font_size 10
      text "<font size='16'><b>Facture</b></font> N°" + @invoice.tracking_id,
        :inline_format => true,
        :align => :right
      font_size 11.5
      text @id_card.city.to_s + ' le ' + french_date(@invoice.date), :align => :right
    end

    # Informations de contact
    bounding_box [50, 585], :width => 235, :height => 50 do
      draw_bounds_debug
      font_size 10
      text '<b>Contact :</b> ' + @id_card.contact_full_name.to_s, :inline_format => true
      text '<b>Tél :</b> ' + @id_card.contact_phone.to_s, :inline_format => true
      text '<b>Email:</b> ' + @id_card.contact_email.to_s, :inline_format => true
    end

    # Informations client
    bounding_box [50, 530], :width => 420, :height => 105 do
      draw_bounds_debug
      font_size 11.5
      text 'A l’attention de :', :style => :bold
      text @invoice.customer.name
      text @invoice.customer.address1
      text @invoice.customer.address2
      text @invoice.customer.zip.to_s + ' ' + @invoice.customer.city.to_s
      text @invoice.customer.country
    end

    # Objet
    bounding_box [50, 425], :width => 350, :height => 30 do
      draw_bounds_debug
      font_size 11
      text '<b>Objet :</b> ' + @invoice.label, :inline_format => true
    end

    # Tableau
    bounding_box [50, 400], :width => 420 do
      draw_bounds_debug
      table_matrix = [['Prestation', 'Prix unitaire', 'Quantité', 'Total HT']]

      # Lignes de facturation

      @invoice.lines.each do |line|
        table_matrix.push [line.label, french_number(euros(line.unit_price), 2),
            french_number(line.quantity),
            french_number(euros(line.total), 2)]
      end

      # Synthèse
      font_size 10
      table_matrix.push ['Net HT', '', '', euros(@invoice.total_duty)]
      vat_rate = french_number(@invoice.vat_rate)
      if (@invoice.advance && @invoice.advance != 0.0)
        table_matrix.push ['Acompte reçu sur commande', '', '', euros(@invoice.advance)]
        table_matrix.push ['Solde à payer', '', '', euros(@invoice.balance)]
      end
      theight = write_table_from_matrix(table_matrix)
    
      move_down 15
      font_size 8.5
      text @id_card.custom_info_2, :color => GREY, :width => 420
      font_size 10

      move_down 15
      text 'Conditions de paiement :'
      text @invoice.payment_term.label

      move_down 10
      text 'Coordonnées bancaires :'
      text 'IBAN : ' + @id_card.iban.to_s
      text 'BIC / SWIFT : ' + @id_card.bic_swift.to_s
    end # Tableau

    # Mentions légales - Bas de page
    bounding_box [50, 37], :width => 425 do
      font "Times-Roman"
      font_size 8.5
      text @id_card.custom_info_3, :color => GREY
    end
  end

  def write_table_from_matrix matrix
    t = table matrix,
    :column_widths => [215, 65, 60, 80],
    :cell_style => {:align => :right, :border_width => 0.5} do
      row(0).style :background_color => LIGHT_GREY # make first row grey
      row(0).style :size => 11
      # reduce font size of invoice lines
      invoice_lines_range = Range.new(1,(matrix.length - 6))
      row(invoice_lines_range).style :size => 9
    end
    return t.height()
  end

  def draw_bounds_debug
    transparent(0.5) { stroke_bounds } if DEBUG
  end

  def write_legal_line text
    text text, :align => :right, :color => GREY
  end

  def french_date date
    date
    french_month = FRENCH_MONTH_NAMES[date.month]
    return date.day.to_s + ' ' + french_month + ' ' + date.year.to_s
  end

  def euros amount
    amount ||= 0
    french_number(amount, 2).to_s + " €"
  end

  def french_number amount, precision = -1
    if precision >= 0
      number_with_precision(amount, :precision => precision, :delimiter => '', :separator => ",")
    else
      number_with_delimiter(amount, :delimiter => '', :separator => ",")
    end
  end

  def number_without_trailling_zero number
    return ("%g" % number)
  end

end

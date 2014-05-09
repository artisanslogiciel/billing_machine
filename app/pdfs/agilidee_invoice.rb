# encoding: utf-8


class AgilideeInvoice < Prawn::Document
  include ActionView::Helpers::NumberHelper
  attr_accessor :invoice
  
  GREY = "808080"
  LIGHT_GREY = "C0C0C0"
  WHITE = "FFFFFF"
  DEBUG = false
  FRENCH_MONTH_NAMES = [nil, 'janvier', 'février', 'mars', 'avril', 'mai',
    'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']
  
  def initialize(invoice)
    super(:page_size => 'A4')#, :bottom_margin => 35)
    @invoice = invoice
  end
  
  def draw_bounds_debug
    transparent(0.5) {stroke_bounds} if DEBUG
  end
  
  def write_legal_line text
    text text, :align => :right, :color => GREY
  end
  
  def invoice_french_date
    date = @invoice.date
    french_month = FRENCH_MONTH_NAMES[date.month]
    return date.day.to_s + ' ' + french_month + ' ' + date.year.to_s
  end

  
  def build
    image Rails.root+'app/pdfs/agilidee_logo.png', at: [55, 735], :width => 150
    
    # Mentions légales - Coin supérieur droit
    bounding_box [235, 735], :width => 235, :height => 75 do
      draw_bounds_debug
      font_size 8
      write_legal_line 'SIRET 522 162 379 00013 APE 6202A'
      write_legal_line 'SARL au capital de 10.000 euros'
      write_legal_line 'RCS MARSEILLE 522 162 379'
      move_down 5
      write_legal_line 'N° TVA FR 05 522 162 379 000 13'
      move_down 15
      write_legal_line '46 Avenue des Chartreux'
      write_legal_line '13004 Marseille'
    end
    
    # Entete de facturation
    bounding_box [340, 585], :width => 130, :height => 75 do
      font_size 10
      text "<font size='16'><b>Facture</b></font> N°" + @invoice.tracking_id,
        :inline_format => true,
        :align => :right
      font_size 11.5
      text 'Marseille le ' + invoice_french_date, :align => :right
      
    end
    
    # Informations client
    bounding_box [50, 585], :width => 235, :height => 75 do
      font_size 10
      text '<b>Contact :</b> Benoit Gantaume', :inline_format => true
      text '<b>Tél :</b> +33.6.76.31.22.91', :inline_format => true
      text '<b>Fax:</b> +33.9.72.14.07.28', :inline_format => true
      text '<b>Email:</b> benoit.gantaume@agilidee.com', :inline_format => true
    end
    
    # Informations client
    bounding_box [50, 530], :width => 450, :height => 75 do
      font_size 11.5
      transparent(0.5) {stroke_bounds} 
      text 'A l’attention de :', :style => :bold
      text @invoice.customer.name
      text @invoice.customer.address1
      text @invoice.customer.address2
      text @invoice.customer.zip.to_s + ' ' + @invoice.customer.city.to_s
    end
    
    # Objet
    bounding_box [50, 420], :width => 235, :height => 75 do
      font_size 11
      text '<b>Objet :</b> ' + @invoice.label, :inline_format => true
    end
    
    # Tableau
    bounding_box [50, 400], :width => 450 do
      table_matrix = [['Prestation', 'Prix unitaire', 'Quantité', 'Total HT']]
      
      # Lignes de facturation

      @invoice.lines.each do |line|
        table_matrix.push [line.label, french_number(line.unit_price, 2),
            french_number(line.quantity),
            french_number(line.total, 2)]
      end
      
      # Synthèse
      font_size 10
      table_matrix.push ['Net HT', '', '', euros(@invoice.total_duty)]
      table_matrix.push ['TVA 20,0 %', '', '', euros(@invoice.vat)]
      table_matrix.push ['Total TTC', '', '', euros(@invoice.total_all_taxes)]
      table_matrix.push ['Acompte reçu sur commande', '', '', euros(@invoice.advance)]
      table_matrix.push ['Solde à payer', '', '', euros(@invoice.balance)]
      write_table_from_matrix(table_matrix)
      
      move_down 15
      text 'Conditions de paiement :'
      text @invoice.payment_term.label
      
      move_down 10
      text 'Coordonnées bancaires :'
      text 'IBAN : ***REMOVED***'
      text 'BIC / SWIFT : ***REMOVED***'
    end # Tableau
    
    # Mentions légales - Bas de page
    bounding_box [50, 37], :width => 425 do
      font "Times-Roman"
      font_size 8.5
      text 'Mention légale', :color => GREY
      text 'Tout retard de règlement donnera lieu de plein droit et sans qu’aucune mise en demeure ne soit nécessaire au paiement de ' +
        'pénalités de retard sur la base du taux BCE majoré de dix (10) points et au paiement d’une indemnité forfaitaire pour frais de ' +
        'recouvrement d’un montant de 40€', :color => GREY
    end
  end
  
  def write_table_from_matrix matrix
      table matrix,
    :column_widths => [215, 65, 60, 80],
    :cell_style => {:align => :right, :border_width => 0.5} do
      row(0).style :background_color => LIGHT_GREY # make first row grey
      row(0).style :size => 11
      # reduce font size of invoice lines
      invoice_lines_range = Range.new(1,(matrix.length - 6))
      row(invoice_lines_range).style :size => 9
    end
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

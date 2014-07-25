# encoding: utf-8


class SudDeveloppementInvoice < Prawn::Document
  include ActionView::Helpers::NumberHelper
  attr_accessor :invoice

  GREY = "808080"
  BLUE = "000060"
  WHITE = "FFFFFF"
  DEBUG = false

  def initialize(invoice)
    super(:page_size => 'A4')
    @invoice = invoice
    @id_card = invoice.id_card
  end

  def draw_bounds_debug
    transparent(0.5) {stroke_bounds} if DEBUG
  end

  def write_legal_line text
    text text, :align => :center, :leading => 3, :color => GREY

  end

  def build
    stroke_axis :step_length => 50, :color => GREY if DEBUG

    if invoice.id_card.logo.exists?
      image invoice.id_card.logo.path, at: [0, 770], :width => 80
    end

    line [85, 770], [85, 0]
    stroke

    line [90, 700], [535, 700]
    stroke

    # Entête
    bounding_box [300, 720], :width => 235, :height => 20 do
      draw_bounds_debug
      font_size 20
      text 'FACTURE', :align => :right, :style => :italic
    end

    # Mentions légales - Colonne de gauche
    bounding_box [0, 650], :width => 80, :height => 620 do
      draw_bounds_debug
      font_size 8
      write_legal_line 'Téléphone'
      write_legal_line @id_card.contact_phone
      write_legal_line ' '
      write_legal_line 'mail à'
      text @id_card.contact_email, :align => :center, :leading => 3, :color => BLUE
      write_legal_line ' '
      write_legal_line 'Courrier à '
      write_legal_line @id_card.contact_address_1
      write_legal_line @id_card.contact_zip
      write_legal_line @id_card.contact_city
      move_down 170
      write_legal_line @id_card.legal_form + " au capital de"
      write_legal_line separate_thousands_with_space(@id_card.capital) + " euros"
      write_legal_line ' '
      write_legal_line @id_card.registration_city
      write_legal_line @id_card.registration_number
      write_legal_line ' '
      write_legal_line 'SIRET'
      write_legal_line @id_card.siret
      write_legal_line ' '
      write_legal_line 'APE/NAF 6831Z'
      write_legal_line ' '
      write_legal_line @id_card.custom_info_2
      write_legal_line ' '
      write_legal_line @id_card.custom_info_3
      write_legal_line ' '
      write_legal_line 'Siège Social à'
      write_legal_line @id_card.address1
      write_legal_line @id_card.zip
      write_legal_line @id_card.city
    end

    # Déclaration
    bounding_box [90, 650], :width => 200, :height => 45 do
      draw_bounds_debug
      font_size 11
      text @id_card.custom_info_1, :style => :italic, :align => :center, :color => GREY
    end

    # Informations client
    bounding_box [300, 680], :width => 235, :height => 75 do
      stroke_bounds
      bounding_box [10, 65], :width => 225 do
        draw_bounds_debug
        font_size 11
        text @invoice.customer.name
        text @invoice.customer.address1
        text @invoice.customer.address2
        text @invoice.customer.zip.to_s + ' ' + @invoice.customer.city.to_s
      end
    end

    # Entete de facturation
    bounding_box [90, 590], :width => 445, :height => 60 do
      font_size 10
      draw_bounds_debug
      table [ ['FACTURE N°', @invoice.tracking_id, 'Date', @invoice.date.strftime("%d/%m/%Y") ]],
            :column_widths => [210, 103, 66, 66],
            :cell_style => { background_color: BLUE, :text_color => WHITE, :align => :center}
      move_down 10
      table [ ['LIBELLES','Q', 'U', 'PU' , 'MONTANT']],
            :column_widths => [210, 50, 53,66,66],
            :cell_style => { background_color: BLUE, :text_color => WHITE, :align => :center}
    end

    # Lignes de facturation
    bounding_box [90, 525], :width => 445, :height => 280 do
      font_size 9
      draw_bounds_debug
      float do
        table [ ['','', '', '' , '']],
            :column_widths => [210, 50, 53,66,66],
            :cell_style => {:height => 280}
      end

      if @invoice.lines.size > 0
        datas = []
        @invoice.lines.each do |line|
          datas.push [line.label,french_number(line.quantity), line.unit, euros(line.unit_price) , euros(line.total)]
        end
        table datas,
            :column_widths => [210, 50, 53,66,66],
            :cell_style => {:borders => []} do
          column(0).style :align => :left
          column(1).style :align => :right
          column(2).style :align => :center
          column(3).style :align => :right
          column(4).style :align => :right
        end
      end

    end


    # Synthèse
    bounding_box [300, 235], :width => 235, :height => 190 do
      draw_bounds_debug
      font_size 9

      vat_rate = french_number(@invoice.vat_rate)
      summary_table([['TOTAL HT', euros(@invoice.total_duty)],
               ["TVA (#{vat_rate}%)", euros(@invoice.vat)],
               ['TOTAL TTC', euros(@invoice.total_all_taxes)]])
      move_down 8
      summary_table([['Acompte reçu sur commande', euros(@invoice.advance)]])
      move_down 8
      summary_table([['Solde à payer', euros(@invoice.balance)]])
      move_down 8

      table([[@invoice.payment_term.try(:label)]],
            :column_widths => [235],
            :cell_style => {:align => :center, :font_style => :italic, :padding => [2, 2, 2, 2]})

      move_down 8
      datas = [['Banque : ' + @id_card.bank_name],
            ['Agence de : ' + @id_card.bank_address],
            ['IBAN : '+ @id_card.iban],
            ['BIC : ' + @id_card.bic_swift]]

      table(datas,
            :column_widths => [235],
            :cell_style => {:padding => [2, 2, 2, 2],:border_color => GREY,  text_color: GREY})

   end

    # Pied de page
    bounding_box [0, -5], :width => 535, :height => 20 do
      draw_bounds_debug
      font_size 11
      float do
        text 'FACTURE ' + @invoice.tracking_id + '  ' +  @invoice.customer.name, :align => :center
      end
      float do
        text 'Page 1 / 1 ', :align => :right
      end
    end

  end

  def summary_table datas
    table(datas,
          :column_widths => [169,66],
          :cell_style => {:padding => [2, 2, 2, 2], font_style: :bold}) do
      column(0).style :align => :left
      column(1).style :align => :right
    end
  end

  def euros amount
    amount ||= 0
    french_number(amount, 2).to_s + " €"
  end

  def french_number amount, precision = -1
    if precision >= 0
      number_with_precision(amount, :precision => precision, :delimiter => '.', :separator => ",")
    else
      number_with_delimiter(amount, :delimiter => '.', :separator => ",")
    end
  end

  def separate_thousands_with_space number
    number_with_delimiter(number, :delimiter => ' ')
  end

end

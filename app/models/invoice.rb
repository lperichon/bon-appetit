# Simple invoice example.
# Copyright August 2008, Gregory Brown (gregory.t.brown@gmail.com).
# All rights reserved.
# -----------------------
#
# Things Prawn could do to make this job easier:
#
#    * allow setting cell height via Cell#new and Document#cell()
#    * position y cursor directly at the bottom of the cell after rendering
#    * calculate text width with respect to line breaks.
#    * Table could right-align numbers and left-align strings by default

require 'prawn/layout'

class Invoice < Prawn::Document
  def initialize(options={})
     @sender     = options[:sender]
     @recipient  = options[:recipient]
     @entries    = []
     @discount = options[:discount]
     @subtotal = options[:subtotal]
     @taxes = options[:taxes]
     @total = options[:total]
     super()
  end

  def entry(name ,qty, unit_price, discount,subtotal)
    @entries << [name, qty, "$#{unit_price}", "$#{qty*unit_price}"]
    if discount > 0
      @entries << ["#{name} - Bonif. %#{discount*100}", "", "", "-$#{qty*unit_price - subtotal}" ]
    end
  end

  def draw_invoice
    font "Times-Roman"
    draw_sender
    draw_recipient

    move_down 100

    pad(10) do
      text "Invoice Items", :align => :center, :size => 16
    end

    table @entries,
      :position   => :center,
      :headers    => ["Name","Quantity","Unit Price", "Subtotal"],
      :row_colors => :pdf_writer,
      :vertical_padding => 2,
      :widths => { 0 => 200, 1 => 100, 2 => 100 }

    totals = []
    totals << ["Subtotal: $#{@subtotal}"]
    if @discount > 0
      totals << ["Bonif. %#{@discount*100}: -$#{@subtotal - @subtotal*@discount}"]
    end
    if @taxes > 0
      totals << ["Taxes: $#{@taxes}"]
    end
    totals << ["Total: $#{@total}"]

    pad(5) do
      table totals,
        :position   => :center,
        :align      => :right,
        :vertical_padding => 2,
        :row_colors => ["ffff40"]
     end
  end

  def draw_sender
    cell bounds.top_left,
      :text    => @sender,
      :horizontal_padding => 10,
      :vertical_padding   => 5,
      :width   => 150
  end

  def draw_recipient
    cell [bounds.left, bounds.top - 60],
      :text    => @recipient,
      :horizontal_padding => 10,
      :vertical_padding   => 5,
      :width   => 150
  end

  def save_as(file)
    draw_invoice
    render_file(file)
  end

end
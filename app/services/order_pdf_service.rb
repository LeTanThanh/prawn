class OrderPdfService
  include ApplicationHelper

  attr_reader :order, :pdf

  def initialize order
    @order = order
    @pdf = Prawn::Document.new
  end

  def perform
    order_token
    order_items
    order_total_price
  end

  private

  def order_token
    @pdf.text "Order ##{@order.token}"
    @pdf.move_down 20
  end

  def order_items
    rows = [["No", "Item", "Price"]]
    @order.items.each.with_index(1) do |item, index|
      rows.push [index, item.name, service_helpers.number_to_currency(item.price)]
    end

    @pdf.table rows
    @pdf.move_down 20
  end

  def order_total_price
    @pdf.text "Total price #{service_helpers.number_to_currency @order.decorate.total_price}"
    @pdf.move_down 20
  end

  def service_helpers
    ApplicationController.helpers
  end
end

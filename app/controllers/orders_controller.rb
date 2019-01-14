class OrdersController < ApplicationController
  def show
    @order = Order.find_by id: params[:id]

    respond_to do |format|
      format.html
      format.pdf do
        disposition = (params[:download] == "true") ? :attachment : :inline

        order_pdf_service = OrderPdfService.new @order
        order_pdf_service.perform

        send_data order_pdf_service.pdf.render, filename: "order_#{@order.token}.pdf",
          type: "application/pdf", status: 200, disposition: disposition
      end
    end
  end
end

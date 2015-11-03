class OrderNotifier < ApplicationMailer

  default from: 'Rajat Bansal <rajat.usict@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.recieved.subject
  #
  def received(order)
    @order = order
    @products = order.products.includes(:images)
    @products.each do |product|

      if product.images.length != 0
        attachments.inline[product.images.first.url] = File.read(Rails.root.join('public','product_images', product.images.first.url.to_s))
        product.images.slice(1, product.images.length - 1).each do |image|
          attachments[image.url] = File.read(Rails.root.join('public','product_images', image.url.to_s))
        end
      end

    end
    mail to: order.email, subject: 'pragmatic Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped
    @order = order

    mail to: order.email, subject: 'pragmatic Store order shipped'
  end
end


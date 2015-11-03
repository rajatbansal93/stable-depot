class UserNotifier < ApplicationMailer

  default from: 'Rajat Bansal <rajat@vinsol.com>'

  def created(user)
    @user = user
    mail(to: @user.email, subject: 'account created succussfully')
  end

  def previous_orders(user)
    @orders = user.orders
    mail(to: user.email, subject: 'Your orders')
  end
end

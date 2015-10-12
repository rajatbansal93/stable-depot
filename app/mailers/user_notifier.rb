class UserNotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier.created.subject
  #
  def created(user)
    @user = user
    mail(to: @user.email, subject: 'account created succussfully')
  end
end

namespace :user do
  desc "TODO"
  task :makeAdmin, [:email_id] => :environment  do |t,args|
    user = User.find_by(email: args[:email_id])
    user.update(role: "admin")
  end

  task :notify_order => :environment do

    @users = User.all.includes(:orders)
    @users.each do |user|
      UserNotifier.previous_orders(user).deliver
    end
  end
end

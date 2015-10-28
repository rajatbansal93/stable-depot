namespace :Product do
  task :port_legacy_products => :environment do
    ActiveRecord::Base.connection.execute("UPDATE products
      SET category_id = 1 ")
  end
end

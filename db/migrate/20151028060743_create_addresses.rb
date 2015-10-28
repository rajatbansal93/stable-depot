class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :state
      t.string :city
      t.string :country
      t.string :pincode

      t.timestamps null: false
    end
  end
end

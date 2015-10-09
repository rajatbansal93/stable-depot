class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :name
      t.string :discount
      t.date :valid_upto
      t.string :max_allowed_discount
    end
  end
end

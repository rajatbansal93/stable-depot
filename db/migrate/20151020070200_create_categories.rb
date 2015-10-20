class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :count
      t.references :parent_comment

      t.timestamps null: false
    end
  end
end

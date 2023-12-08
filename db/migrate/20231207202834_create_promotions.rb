class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :promotion_type, null: false
      t.integer :threshold, null: false
      t.json :rules

      t.timestamps
    end
  end
end

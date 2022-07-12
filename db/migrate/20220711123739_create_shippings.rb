class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.string :post_code,        null: false
      t.integer :prefecture_id,   null: false
      t.string :city_town,        null: false
      t.string :address_2,        null: false
      t.string :address_1
      t.integer :tel,             null: false
      t.references :order,        null: false, foreign_key: true

      t.timestamps
    end
  end
end

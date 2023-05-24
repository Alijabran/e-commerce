class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.integer :discount_value

      t.timestamps
    end
  end
end

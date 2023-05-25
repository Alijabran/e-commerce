class AddConstraintToCoupon < ActiveRecord::Migration[6.1]
  def up
    execute 'ALTER TABLE coupons ADD CONSTRAINT discount_check CHECK (discount_value <= 100)'
  end

  def down
    execute 'ALTER TABLE coupons DROP CONSTRAINT discount_check'
  end
end

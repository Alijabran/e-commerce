class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders, &:timestamps
  end
end

class AddIndexSpreeOrders < ActiveRecord::Migration[6.0]
  def change
    add_index :spree_order_commissions, ["order_id", "vendor_id"]
    add_index :spree_order_promotions, ["promotion_id", "order_id"]
  end
end

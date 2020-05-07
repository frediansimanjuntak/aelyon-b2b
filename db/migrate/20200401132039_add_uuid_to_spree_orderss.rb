class AddUuidToSpreeOrderss < ActiveRecord::Migration[6.0]
  def up
    add_column :spree_orders, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_adjustments, :order_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_inventory_units, :order_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_line_items, :order_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_order_commissions, :order_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_order_promotions, :order_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_payments, :order_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_reimbursements, :order_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_return_authorizations, :order_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_shipments, :order_uuid, :uuid, default: "gen_random_uuid()", null: false

    # Populate UUID columns for associations
    execute "UPDATE spree_adjustments SET order_uuid = spree_orders.uuid FROM spree_orders WHERE spree_adjustments.order_id = spree_orders.id;"
    execute "UPDATE spree_inventory_units SET order_uuid = spree_orders.uuid FROM spree_orders WHERE spree_inventory_units.order_id = spree_orders.id;"
    execute "UPDATE spree_line_items SET order_uuid = spree_orders.uuid FROM spree_orders WHERE spree_line_items.order_id = spree_orders.id;"
    execute "UPDATE spree_order_commissions SET order_uuid = spree_orders.uuid FROM spree_orders WHERE spree_order_commissions.order_id = spree_orders.id;"
    execute "UPDATE spree_order_promotions SET order_uuid = spree_orders.uuid FROM spree_orders WHERE spree_order_promotions.order_id = spree_orders.id;"
    execute "UPDATE spree_payments SET order_uuid = spree_orders.uuid FROM spree_orders WHERE spree_payments.order_id = spree_orders.id;"
    execute "UPDATE spree_reimbursements SET order_uuid = spree_orders.uuid FROM spree_orders WHERE spree_reimbursements.order_id = spree_orders.id;"
    execute "UPDATE spree_shipments SET order_uuid = spree_orders.uuid FROM spree_orders WHERE spree_shipments.order_id = spree_orders.id;"
    execute "UPDATE spree_return_authorizations SET order_uuid = spree_orders.uuid FROM spree_orders WHERE spree_return_authorizations.order_id = spree_orders.id;"
    

    # Migrate UUID to ID for associations
    remove_column :spree_adjustments, :order_id
    rename_column :spree_adjustments, :order_uuid, :order_id
    remove_column :spree_inventory_units, :order_id
    rename_column :spree_inventory_units, :order_uuid, :order_id
    remove_column :spree_line_items, :order_id
    rename_column :spree_line_items, :order_uuid, :order_id
    remove_column :spree_order_commissions, :order_id
    rename_column :spree_order_commissions, :order_uuid, :order_id
    remove_column :spree_order_promotions, :order_id
    rename_column :spree_order_promotions, :order_uuid, :order_id
    remove_column :spree_payments, :order_id
    rename_column :spree_payments, :order_uuid, :order_id
    remove_column :spree_reimbursements, :order_id
    rename_column :spree_reimbursements, :order_uuid, :order_id
    remove_column :spree_return_authorizations, :order_id
    rename_column :spree_return_authorizations, :order_uuid, :order_id
    remove_column :spree_shipments, :order_id
    rename_column :spree_shipments, :order_uuid, :order_id
    
    # Add indexes for associations
    add_index :spree_adjustments, :order_id
    add_index :spree_inventory_units, :order_id
    add_index :spree_line_items, :order_id
    add_index :spree_order_commissions, :order_id
    add_index :spree_order_promotions, :order_id
    add_index :spree_payments, :order_id
    add_index :spree_reimbursements, :order_id
    add_index :spree_return_authorizations, :order_id
    add_index :spree_shipments, :order_id
    
    # Migrate primary keys from UUIDs to IDs
    remove_column :spree_orders, :id
    rename_column :spree_orders, :uuid, :id
    execute "ALTER TABLE spree_orders ADD PRIMARY KEY (id);"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

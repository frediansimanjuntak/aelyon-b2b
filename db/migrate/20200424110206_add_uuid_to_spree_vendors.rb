class AddUuidToSpreeVendors < ActiveRecord::Migration[6.0]
  def up
    add_column :spree_vendors, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_vendor_users, :vendor_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_option_types, :vendor_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_properties, :vendor_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_products, :vendor_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_stock_locations, :vendor_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_shipping_methods, :vendor_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_variants, :vendor_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_user_references, :vendor_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_user_references, :user_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_user_references, :department_uuid, :uuid, default: "gen_random_uuid()", null: false

    # Migrate UUID to ID for associations
    remove_column :spree_vendor_users, :vendor_id
    rename_column :spree_vendor_users, :vendor_uuid, :vendor_id
    remove_column :spree_option_types, :vendor_id
    rename_column :spree_option_types, :vendor_uuid, :vendor_id
    remove_column :spree_properties, :vendor_id
    rename_column :spree_properties, :vendor_uuid, :vendor_id
    remove_column :spree_products, :vendor_id
    rename_column :spree_products, :vendor_uuid, :vendor_id
    remove_column :spree_stock_locations, :vendor_id
    rename_column :spree_stock_locations, :vendor_uuid, :vendor_id
    remove_column :spree_shipping_methods, :vendor_id
    rename_column :spree_shipping_methods, :vendor_uuid, :vendor_id
    remove_column :spree_variants, :vendor_id
    rename_column :spree_variants, :vendor_uuid, :vendor_id
    remove_column :spree_user_references, :vendor_id
    rename_column :spree_user_references, :vendor_uuid, :vendor_id

    remove_column :spree_user_references, :user_id
    rename_column :spree_user_references, :user_uuid, :user_id
    remove_column :spree_user_references, :department_id
    rename_column :spree_user_references, :department_uuid, :department_id

    # Add indexes for associations
    add_index :spree_vendor_users, :vendor_id
    add_index :spree_option_types, :vendor_id
    add_index :spree_properties, :vendor_id
    add_index :spree_products, :vendor_id
    add_index :spree_stock_locations, :vendor_id
    add_index :spree_shipping_methods, :vendor_id
    add_index :spree_variants, :vendor_id
    add_index :spree_user_references, :vendor_id
    add_index :spree_user_references, :user_id
    add_index :spree_user_references, :department_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

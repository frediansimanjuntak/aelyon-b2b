class AddUuidSpreeUsersToSpreeVendorUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :spree_vendor_users, :user_uuid, :uuid, default: "gen_random_uuid()", null: false

    # Migrate UUID to ID for associations
    remove_column :spree_vendor_users, :user_id
    rename_column :spree_vendor_users, :user_uuid, :user_id

    # Add indexes for associations
    add_index :spree_vendor_users, :user_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

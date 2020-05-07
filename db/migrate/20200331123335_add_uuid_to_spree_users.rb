class AddUuidToSpreeUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :spree_users, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_addresses, :user_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_credit_cards, :user_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_orders, :user_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_promotion_rule_users, :user_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_promotion_rules, :user_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_role_users, :user_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_state_changes, :user_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_store_credits, :user_uuid, :uuid, default: "gen_random_uuid()", null: false

    # Populate UUID columns for associations
    execute "UPDATE spree_addresses SET user_uuid = spree_users.uuid FROM spree_users WHERE spree_addresses.user_id = spree_users.id;"
    execute "UPDATE spree_credit_cards SET user_uuid = spree_users.uuid FROM spree_users WHERE spree_credit_cards.user_id = spree_users.id;"
    execute "UPDATE spree_orders SET user_uuid = spree_users.uuid FROM spree_users WHERE spree_orders.user_id = spree_users.id;"
    execute "UPDATE spree_promotion_rule_users SET user_uuid = spree_users.uuid FROM spree_users WHERE spree_promotion_rule_users.user_id = spree_users.id;"
    execute "UPDATE spree_promotion_rules SET user_uuid = spree_users.uuid FROM spree_users WHERE spree_promotion_rules.user_id = spree_users.id;"
    execute "UPDATE spree_role_users SET user_uuid = spree_users.uuid FROM spree_users WHERE spree_role_users.user_id = spree_users.id;"
    execute "UPDATE spree_state_changes SET user_uuid = spree_users.uuid FROM spree_users WHERE spree_state_changes.user_id = spree_users.id;"
    execute "UPDATE spree_store_credits SET user_uuid = spree_users.uuid FROM spree_users WHERE spree_store_credits.user_id = spree_users.id;"

    # Migrate UUID to ID for associations
    remove_column :spree_addresses, :user_id
    rename_column :spree_addresses, :user_uuid, :user_id
    remove_column :spree_credit_cards, :user_id
    rename_column :spree_credit_cards, :user_uuid, :user_id
    remove_column :spree_orders, :user_id
    rename_column :spree_orders, :user_uuid, :user_id
    remove_column :spree_promotion_rule_users, :user_id
    rename_column :spree_promotion_rule_users, :user_uuid, :user_id
    remove_column :spree_promotion_rules, :user_id
    rename_column :spree_promotion_rules, :user_uuid, :user_id
    remove_column :spree_role_users, :user_id
    rename_column :spree_role_users, :user_uuid, :user_id
    remove_column :spree_state_changes, :user_id
    rename_column :spree_state_changes, :user_uuid, :user_id
    remove_column :spree_store_credits, :user_id
    rename_column :spree_store_credits, :user_uuid, :user_id

    # Add indexes for associations
    add_index :spree_addresses, :user_id
    add_index :spree_credit_cards, :user_id
    add_index :spree_orders, :user_id
    add_index :spree_promotion_rule_users, :user_id
    add_index :spree_promotion_rules, :user_id
    add_index :spree_role_users, :user_id
    add_index :spree_state_changes, :user_id
    add_index :spree_store_credits, :user_id

    # Migrate primary keys from UUIDs to IDs
    remove_column :spree_users, :id
    rename_column :spree_users, :uuid, :id
    execute "ALTER TABLE spree_users ADD PRIMARY KEY (id);"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

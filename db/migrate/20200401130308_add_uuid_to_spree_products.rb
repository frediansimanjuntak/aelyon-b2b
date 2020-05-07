class AddUuidToSpreeProducts < ActiveRecord::Migration[6.0]
  def up
    add_column :spree_products, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_product_option_types, :product_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_product_promotion_rules, :product_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_product_properties, :product_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_products_taxons, :product_uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_variants, :product_uuid, :uuid, default: "gen_random_uuid()", null: false

    # Populate UUID columns for associations
    execute "UPDATE spree_product_option_types SET product_uuid = spree_products.uuid FROM spree_products WHERE spree_product_option_types.product_id = spree_products.id;"
    execute "UPDATE spree_product_promotion_rules SET product_uuid = spree_products.uuid FROM spree_products WHERE spree_product_promotion_rules.product_id = spree_products.id;"
    execute "UPDATE spree_product_properties SET product_uuid = spree_products.uuid FROM spree_products WHERE spree_product_properties.product_id = spree_products.id;"
    execute "UPDATE spree_products_taxons SET product_uuid = spree_products.uuid FROM spree_products WHERE spree_products_taxons.product_id = spree_products.id;"
    execute "UPDATE spree_variants SET product_uuid = spree_products.uuid FROM spree_products WHERE spree_variants.product_id = spree_products.id;"

    # Migrate UUID to ID for associations
    remove_column :spree_product_option_types, :product_id
    rename_column :spree_product_option_types, :product_uuid, :product_id
    remove_column :spree_product_promotion_rules, :product_id
    rename_column :spree_product_promotion_rules, :product_uuid, :product_id
    remove_column :spree_product_properties, :product_id
    rename_column :spree_product_properties, :product_uuid, :product_id
    remove_column :spree_products_taxons, :product_id
    rename_column :spree_products_taxons, :product_uuid, :product_id
    remove_column :spree_variants, :product_id
    rename_column :spree_variants, :product_uuid, :product_id

    # Add indexes for associations
    add_index :spree_product_option_types, :product_id
    add_index :spree_product_promotion_rules, :product_id
    add_index :spree_product_properties, :product_id
    add_index :spree_products_taxons, :product_id
    add_index :spree_variants, :product_id

    # Migrate primary keys from UUIDs to IDs
    remove_column :spree_products, :id
    rename_column :spree_products, :uuid, :id
    execute "ALTER TABLE spree_products ADD PRIMARY KEY (id);"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

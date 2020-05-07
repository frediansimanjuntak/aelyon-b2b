class AddUuidToFriendlyIdSlugs < ActiveRecord::Migration[6.0]
  def up
    add_column :friendly_id_slugs, :sluggable_uuid, :uuid, default: "gen_random_uuid()", null: false

    # Migrate UUID to ID for associations
    remove_column :friendly_id_slugs, :sluggable_id
    rename_column :friendly_id_slugs, :sluggable_uuid, :sluggable_id

    # Add indexes for associations
    add_index :friendly_id_slugs, :sluggable_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

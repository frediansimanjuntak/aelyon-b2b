class CreateSpreeVendorDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_vendor_details, id: :uuid do |t|
      t.string :name
      t.json :business_identity
      t.string :email
      t.string :website
      t.boolean :activated, default: false
      t.uuid :vendor_id
      t.json :distribution_center_address
      t.references :address
      t.timestamps
    end
    add_index :spree_vendor_details, :vendor_id
  end
end

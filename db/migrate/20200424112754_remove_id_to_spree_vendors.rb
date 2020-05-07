class RemoveIdToSpreeVendors < ActiveRecord::Migration[6.0]
  def change
    remove_column :spree_vendors, :company_id
    remove_column :spree_vendors, :company_id_type 
    remove_column :spree_vendors, :website
    remove_column :spree_vendors, :email
    remove_column :spree_vendors, :country_id
    remove_column :spree_vendors, :state_id
    remove_column :spree_vendors, :city
    remove_column :spree_vendors, :office_address
    remove_column :spree_vendors, :distribution_address
    # Migrate UUID to ID for associations
    remove_column :spree_vendors, :id
    rename_column :spree_vendors, :uuid, :id
    execute "ALTER TABLE spree_vendors ADD PRIMARY KEY (id);"
  end
end

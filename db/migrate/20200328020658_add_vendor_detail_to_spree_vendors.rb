class AddVendorDetailToSpreeVendors < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_vendors, :company_id, :string
    add_column :spree_vendors, :company_id_type, :string    
    add_column :spree_vendors, :website, :string
    add_column :spree_vendors, :email, :string
    add_column :spree_vendors, :country_id, :integer
    add_column :spree_vendors, :state_id, :integer
    add_column :spree_vendors, :city, :string
    add_column :spree_vendors, :office_address, :string
    add_column :spree_vendors, :distribution_address, :string  
    add_index :spree_vendors, :country_id
    add_index :spree_vendors, :state_id
  end
end

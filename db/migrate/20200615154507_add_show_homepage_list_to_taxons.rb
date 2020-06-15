class AddShowHomepageListToTaxons < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_taxons, :show_homepage_list, :boolean, default: false, index: true
  end
end

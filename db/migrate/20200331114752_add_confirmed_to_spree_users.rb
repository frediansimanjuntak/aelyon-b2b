class AddConfirmedToSpreeUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_users, :is_confirmed, :boolean, :default => false, :null => false
  end
end

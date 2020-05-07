class CreateSpreeUserReferences < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_user_references, id: :uuid do |t|
      t.references :vendor
      t.references :user
      t.references :department
      t.references :role
    end
  end
end

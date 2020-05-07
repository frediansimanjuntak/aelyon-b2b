class CreateSpreeDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_departments, id: :uuid do |t|
      t.string :name
      t.string :description
      t.boolean :activated, default: true
      t.timestamps
    end
  end
end

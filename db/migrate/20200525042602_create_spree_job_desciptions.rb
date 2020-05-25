class CreateSpreeJobDesciptions < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_job_descriptions, id: :uuid do |t|
      t.string :name
      t.string :model_type
      t.json :permission
      t.boolean :activated, default: true
      t.timestamps
    end
  end
end

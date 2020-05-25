class AddDepartmentToJobDescription < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_job_descriptions, :department_id, :uuid, default: "gen_random_uuid()", null: false
    add_index :spree_job_descriptions, :department_id
  end
end

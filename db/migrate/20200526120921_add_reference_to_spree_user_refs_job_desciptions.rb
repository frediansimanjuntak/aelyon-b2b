class AddReferenceToSpreeUserRefsJobDesciptions < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_user_refs_job_descs, :department_id, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_user_refs_job_descs, :user_id, :uuid, default: "gen_random_uuid()", null: false
    add_column :spree_user_refs_job_descs, :job_description_id, :uuid, default: "gen_random_uuid()", null: false
    add_index :spree_user_refs_job_descs, :department_id
    add_index :spree_user_refs_job_descs, :user_id
    add_index :spree_user_refs_job_descs, :job_description_id
  end
end

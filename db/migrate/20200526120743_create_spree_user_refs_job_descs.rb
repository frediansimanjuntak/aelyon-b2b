class CreateSpreeUserRefsJobDescs < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_user_refs_job_descs, id: :uuid do |t|

      t.timestamps
    end
  end
end

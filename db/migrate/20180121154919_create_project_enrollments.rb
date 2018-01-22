class CreateProjectEnrollments < ActiveRecord::Migration[5.1]
  def up
    create_table :project_enrollments do |t|
      t.integer :employee_id
      t.integer :project_id

      t.timestamps
    end
    add_index :project_enrollments, [ :employee_id , :project_id ]
  end

  def down
    drop_table :project_enrollments
  end
end

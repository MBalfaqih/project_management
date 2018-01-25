class CreateEmployeesProjects < ActiveRecord::Migration[5.1]
  def up
    create_table :employees_projects do |t|
      t.references :employee , foreign_key: true , index: true
      t.references :project  , foreign_key: true , index: true
      
      t.timestamps
    end
  end

  def down
    drop_table :employees_projects
  end
end

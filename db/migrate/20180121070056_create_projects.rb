class CreateProjects < ActiveRecord::Migration[5.1]
  def up
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :company_id
      t.timestamps
    end
    add_index :projects , :company_id
  end


  def down
    drop_table :projects
  end

end

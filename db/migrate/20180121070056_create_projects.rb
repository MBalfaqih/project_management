class CreateProjects < ActiveRecord::Migration[5.1]
  def up
    create_table   :projects do |t|
      t.string     :name
      t.text       :description
      t.references :company , foreign_key: true , index: true
      
      t.timestamps
    end
  end


  def down
    drop_table :projects
  end

end

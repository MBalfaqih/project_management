class CreateEmployees < ActiveRecord::Migration[5.1]
  def up
    create_table :employees do |t|
      t.integer :company_id
      t.string :name
      t.date :joining_date
      t.date :birth_date

      t.timestamps
    end
    add_index :employees , :company_id
  end

  def down
    drop_table :employees
  end
end

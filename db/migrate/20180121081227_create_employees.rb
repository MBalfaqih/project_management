class CreateEmployees < ActiveRecord::Migration[5.1]
  def up
    create_table   :employees do |t|
      t.references :company , foreign_key: true , index: true
      t.string     :name
      t.date       :joining_date
      t.date       :birth_date

      t.timestamps
    end
  end

  def down
    drop_table :employees
  end
end

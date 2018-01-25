class CreateTasks < ActiveRecord::Migration[5.1]
  def up
    create_table :tasks do |t|
      t.string     :name
      t.text       :description
      t.string     :status
      t.references :project , foreign_key: true, index: true
      t.references :assignee, foreign_key: {to_table: :employees}, index: true

      t.timestamps
    end
  end

  def down
    drop_table :tasks

end

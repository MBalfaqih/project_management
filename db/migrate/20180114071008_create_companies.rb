class CreateCompanies < ActiveRecord::Migration[5.1]
  def up
    create_table   :companies do |t|
      t.string     :username
      t.string     :company_name
      t.string     :email
      t.string     :token
      t.string     :password_digest
      t.string     :password_reset_token
      t.attachment :logo
      t.timestamps
    end
    add_index   :companies, :token, unique: true
  end

  def down
    drop_table :companies 
  end
end

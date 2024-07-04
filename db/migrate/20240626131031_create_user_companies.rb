class CreateUserCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :user_companies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :corporate_name, null: false
      t.string :corporate_number, null: false
      t.integer :industry_id, null: false

      t.timestamps
    end
  end
end

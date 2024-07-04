class CreateCompanyLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :company_links do |t|
      t.references :user_company, null: false, foreign_key: true
      t.string :name
      t.string :href

      t.timestamps
    end
  end
end

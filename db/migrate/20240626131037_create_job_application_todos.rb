class CreateJobApplicationTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :job_application_todos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job_application, null: false, foreign_key: true
      t.string :name, null: false
      t.datetime :deadline
      t.integer :status, null: false
      t.text :note

      t.timestamps
    end
  end
end

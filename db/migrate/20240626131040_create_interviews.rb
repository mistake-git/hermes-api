class CreateInterviews < ActiveRecord::Migration[7.0]
  def change
    create_table :interviews do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.references :job_application, null: false, foreign_key: true
      t.datetime :interview_time_from, null: false
      t.datetime :interview_time_to, null: false
      t.string :interview_type, null: false
      t.string :interview_url
      t.string :interview_address
      t.integer :status, null: false

      t.timestamps
    end
  end
end

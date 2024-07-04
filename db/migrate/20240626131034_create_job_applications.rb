class CreateJobApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_company, null: false, foreign_key: true
      t.string :name, null: false
      t.string :job_type, null: false
      t.string :reason_for_personal_link
      t.string :reason_for_interview_link
      t.integer :annual_income
      t.integer :level_of_interest, null: false
      t.integer :employment_type
      t.integer :status, null: false
      

      t.timestamps
    end
  end
end

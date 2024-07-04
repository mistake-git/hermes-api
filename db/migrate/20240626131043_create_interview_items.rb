class CreateInterviewItems < ActiveRecord::Migration[7.0]
  def change
    create_table :interview_items do |t|
      t.references :interview, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end

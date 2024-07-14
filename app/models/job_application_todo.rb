# == Schema Information
#
# Table name: job_application_todos
#
#  id                 :bigint           not null, primary key
#  deadline           :datetime
#  name               :string(255)      not null
#  note               :text(65535)
#  status             :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  job_application_id :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_job_application_todos_on_job_application_id  (job_application_id)
#  index_job_application_todos_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_application_id => job_applications.id)
#  fk_rails_...  (user_id => users.id)
#
class JobApplicationTodo < ApplicationRecord
  belongs_to :user
  belongs_to :job_application

  validates :name, presence: true
  validates :status, presence: true
  validates :job_application_id, presence: true

  validate :deadline_in_future

  private

  def deadline_in_future
    if deadline.present? && deadline < DateTime.now
      errors.add(:deadline, "締切は未来の日付にしてください")
    end
  end
end

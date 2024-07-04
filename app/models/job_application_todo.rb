class JobApplicationTodo < ApplicationRecord
  belongs_to :user
  belongs_to :job_application
end

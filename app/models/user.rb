class User < ApplicationRecord
  has_many :job_applications, dependent: :destroy
  has_many :interviews, dependent: :destroy
  has_many :job_application_todos, dependent: :destroy
end

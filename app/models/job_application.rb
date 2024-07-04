class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :user_company
  has_many :interviews, dependent: :destroy
  has_many :job_application_todos, dependent: :destroy
  accepts_nested_attributes_for :user_company
end

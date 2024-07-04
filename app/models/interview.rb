class Interview < ApplicationRecord
  belongs_to :user
  belongs_to :job_application
  has_many :interview_items, dependent: :destroy
  accepts_nested_attributes_for :interview_items
end

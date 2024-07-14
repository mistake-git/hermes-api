# == Schema Information
#
# Table name: job_applications
#
#  id                        :bigint           not null, primary key
#  annual_income             :integer
#  employment_type           :integer
#  job_type                  :string(255)      not null
#  level_of_interest         :integer          not null
#  name                      :string(255)      not null
#  reason_for_interview_link :string(255)
#  reason_for_personal_link  :string(255)
#  status                    :integer          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  user_company_id           :bigint           not null
#  user_id                   :bigint           not null
#
# Indexes
#
#  index_job_applications_on_user_company_id  (user_company_id)
#  index_job_applications_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_company_id => user_companies.id)
#  fk_rails_...  (user_id => users.id)
#
class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :user_company
  has_many :interviews, dependent: :destroy
  has_many :job_application_todos, dependent: :destroy
  accepts_nested_attributes_for :user_company

  validates :job_type, presence: true
  validates :level_of_interest, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :name, presence: true
  validates :status, presence: true, numericality: { only_integer: true }
  validates :user_company_id, presence: true
  validates :user_id, presence: true
  validates :annual_income, numericality: { only_integer: true}
  validates :employment_type, numericality: { only_integer: true}
  validates :reason_for_interview_link, length: { maximum: 100, allow_nil: true }
  validates :reason_for_personal_link, length: { maximum: 100, allow_nil: true }
end

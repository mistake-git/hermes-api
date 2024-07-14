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
end

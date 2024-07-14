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
class JobApplicationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :user_company_id, :name, :job_type, :reason_for_personal_link, :status, :reason_for_interview_link, :annual_income, :level_of_interest, :employment_type, :created_at, :updated_at, :user_company_attributes, :interviews_attributes, :job_application_todos_attributes

  def user_company_attributes
    ActiveModel::SerializableResource.new(object.user_company, serializers: UserCompanySerializer)
  end

  def interviews_attributes
    ActiveModel::SerializableResource.new(object.interviews, serializers: InterviewSerializer)
  end

  def job_application_todos_attributes
    ActiveModel::SerializableResource.new(object.job_application_todos, serializers: JobApplicationTodoSerializer)
  end

end

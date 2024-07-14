# == Schema Information
#
# Table name: interviews
#
#  id                  :bigint           not null, primary key
#  interview_address   :string(255)
#  interview_time_from :datetime         not null
#  interview_time_to   :datetime         not null
#  interview_type      :string(255)      not null
#  interview_url       :string(255)
#  name                :string(255)      not null
#  status              :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  job_application_id  :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_interviews_on_job_application_id  (job_application_id)
#  index_interviews_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_application_id => job_applications.id)
#  fk_rails_...  (user_id => users.id)
#
class InterviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :interview_time_from, :interview_time_to, :formatted_interview_time_from, :formatted_interview_time_to, :interview_type, :interview_url, :interview_address, :status, :interview_items_attributes, :job_application, :user_company_attributes

  def interview_items_attributes
    ActiveModel::SerializableResource.new(object.interview_items, each_serializer: InterviewItemSerializer)
  end

  def formatted_interview_time_from
    object.interview_time_from.strftime("%Y年%m月%d日 %H:%M")
  end
  
  def formatted_interview_time_to
    object.interview_time_to.strftime("%Y年%m月%d日 %H:%M")
  end

  def user_company_attributes
    ActiveModel::SerializableResource.new(object.job_application.user_company, serializers: UserCompanySerializer)
  end
  
end

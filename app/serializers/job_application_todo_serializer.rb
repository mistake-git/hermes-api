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
class JobApplicationTodoSerializer < ActiveModel::Serializer
  attributes :id, :name, :deadline, :status, :formatted_deadline, :note, :job_application, :user_company_attributes

  def formatted_deadline
    object.deadline&.strftime("%Y年%m月%d日")
  end

  def user_company_attributes
    ActiveModel::SerializableResource.new(object.job_application.user_company, serializers: UserCompanySerializer)
  end

end

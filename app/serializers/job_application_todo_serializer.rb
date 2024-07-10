class JobApplicationTodoSerializer < ActiveModel::Serializer
  attributes :id, :name, :deadline, :status, :formatted_deadline, :note, :job_application, :user_company_attributes

  def formatted_deadline
    object.deadline&.strftime("%Y年%m月%d日")
  end

  def user_company_attributes
    ActiveModel::SerializableResource.new(object.job_application.user_company, serializers: UserCompanySerializer)
  end

end

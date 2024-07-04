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

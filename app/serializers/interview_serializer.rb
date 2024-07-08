class InterviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :interview_time_from, :interview_time_to, :formatted_interview_time_from, :formatted_interview_time_to, :interview_type, :interview_url, :interview_address, :status, :interview_items_attributes, :job_application

  def interview_items_attributes
    ActiveModel::SerializableResource.new(object.interview_items, each_serializer: InterviewItemSerializer)
  end

  def formatted_interview_time_from
    object.interview_time_from.strftime("%Y年%m月%d日 %H:%M")
  end
  
  def formatted_interview_time_to
    object.interview_time_to.strftime("%Y年%m月%d日 %H:%M")
  end
  
end

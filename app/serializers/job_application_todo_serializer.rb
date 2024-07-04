class JobApplicationTodoSerializer < ActiveModel::Serializer
  attributes :id, :name, :deadline, :status, :formatted_deadline, :note

  def formatted_deadline
    object.deadline&.strftime("%Y年%m月%d日")
  end

end

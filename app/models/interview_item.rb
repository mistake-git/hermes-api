# == Schema Information
#
# Table name: interview_items
#
#  id           :bigint           not null, primary key
#  name         :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  interview_id :bigint           not null
#
# Indexes
#
#  index_interview_items_on_interview_id  (interview_id)
#
# Foreign Keys
#
#  fk_rails_...  (interview_id => interviews.id)
#
class InterviewItem < ApplicationRecord
  belongs_to :interview
  validates :name, presence: true
end

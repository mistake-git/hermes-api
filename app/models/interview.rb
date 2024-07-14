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
class Interview < ApplicationRecord
  belongs_to :user
  belongs_to :job_application
  has_many :interview_items, dependent: :destroy
  accepts_nested_attributes_for :interview_items

  validates :interview_time_from, presence: true
  validates :interview_time_to, presence: true
  validates :interview_type, presence: true
  validates :name, presence: true
  validates :status, presence: true

  validate :interview_time_consistency

  private

  def interview_time_consistency
    if interview_time_from.present? && interview_time_to.present? && interview_time_from >= interview_time_to
      errors.add(:interview_time_from, "must be before interview_time_to")
    end
  end
end

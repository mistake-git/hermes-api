# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string(255)      not null
#  name       :string(255)      not null
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :job_applications, dependent: :destroy
  has_many :interviews, dependent: :destroy
  has_many :job_application_todos, dependent: :destroy

  validates :email, presence: true, length: { maximum: 100 }, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { maximum: 100  }
  validates :provider, presence: true, length: { maximum: 100 }
  validates :uid, presence: true, length: { maximum: 100 }, uniqueness: { scope: :provider }
end

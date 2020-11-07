class Project < ApplicationRecord
  has_many :project_users
  has_many :users, through: :project_users, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
end

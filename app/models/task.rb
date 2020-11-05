class Task < ApplicationRecord
  belongs_to :project

  validates :task_name, presence: true

end

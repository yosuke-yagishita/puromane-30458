class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string      :task_name,  null: false
      t.string      :person_in_charge
      t.date        :plan
      t.date        :completion_date
      t.references  :user,       foreign_key: true
      t.references  :project,    foreign_key: true
      t.timestamps
    end
  end
end

FactoryBot.define do
  factory :task do
    task_name { 'タスクの名前' }
    person_in_charge { '担当者名' }
    plan { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
    completion_date { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
    association :user
    association :project
  end
end

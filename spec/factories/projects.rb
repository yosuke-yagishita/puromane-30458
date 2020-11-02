FactoryBot.define do
  factory :project do
    title { Faker::Team.name }
  end
end

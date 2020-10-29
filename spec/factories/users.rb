FactoryBot.define do
  factory :user do
    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.free_email }
    family_name { '山田' }
    first_name  { '太郎' }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end

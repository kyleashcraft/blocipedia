FactoryBot.define do
  require 'random_data'

  factory :user do
    email RandomData.random_email
    password 'password'
  end
end

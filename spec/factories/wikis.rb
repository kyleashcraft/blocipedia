FactoryBot.define do
  require 'random_data'

  factory :wiki do
    title RandomData.random_word
    body RandomData.random_paragraph
    private false
  end
end

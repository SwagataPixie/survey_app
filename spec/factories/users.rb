FactoryGirl.define do
  factory :user do
    name 'Test'
    email "test+#{Random.rand(10..99)}@gmail.com"
  end
end

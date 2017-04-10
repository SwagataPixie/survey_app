FactoryGirl.define do
  factory :question do
    statement 'Some?'
    association :question_type, factory: :question_type
  end
end

FactoryGirl.define do
  factory :review do
    comment "MyText"
    rating 1
    user_id 1
    restaurant_id 1
  end
end

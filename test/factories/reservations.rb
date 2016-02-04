FactoryGirl.define do
  factory :reservation do
    time { Time.now }
    party_size { (1..200).to_a.sample }
  end
end

FactoryBot.define do
  factory :proposal do
    date { '2018-10-31' }
    status { :pending }
    negotiation { :trade }
    association :sender, factory: :user
    association :receiver, factory: :user
  end
end

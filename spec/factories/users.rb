FactoryBot.define do
  factory :user do
    name { 'Pedro Alvares Cabral' }
    sequence :email do |n|
      "pedro#{n}@alvares.com"
    end
    password { '123456' }
    phone { '123456' }
  end
end

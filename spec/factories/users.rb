FactoryBot.define do
  factory :user do
    name { 'Pedro Alvares Cabral' }
    email { 'pedro@alvares.com' }
    password { '123456' }
    phone { '123456' }
  end
end

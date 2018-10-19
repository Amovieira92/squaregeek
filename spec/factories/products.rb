FactoryBot.define do
  factory :product do
    title { 'HQ Batman: Knight Fall' }
    description { 'HQ da queda do homem morcego' }
    category
    condition
    negotiation { :trade }
    price { '1000,00' }
    user
  end
end

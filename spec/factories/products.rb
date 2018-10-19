FactoryBot.define do
  factory :product do
    category
    condition
    title { 'HQ Batman: Knight Fall' }
    description { 'HQ da queda do homem morcego' }
    negotiation { :trade }
    price { '1000,00' }
    user
    photo { File.new(Rails.root.join('spec', 'support', 'knightfall.jpg')) }
  end
end

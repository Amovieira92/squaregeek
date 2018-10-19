FactoryBot.define do
  factory :product do
    title { 'Batman' }
    description { 'Melhor quadrinho do morcegão' }
    category
    condition
    price { 40.0 }
    negotiation { 'trade' }
    photo { File.new(Rails.root.join('spec', 'support', 'knightfall.jpg')) }
    user
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


first_user = User.create(name: 'Antonio', email: 'antonio@teste.com',
password: '123456', city: 'Osasco',
state: 'Sao Paulo', phone: '123456')

second_user = User.create(name: 'Lucas', email: 'lucas@teste.com',
password: '123456', city: 'São Paulo',
state: 'Sao Paulo', phone: '123456')

third_user = User.create(name: 'Patricia', email: 'patricia@teste.com',
password: '123456', city: 'São Paulo',
state: 'Sao Paulo', phone: '123456')

#fourth_user = User.create(name: 'Jônatas', email: 'jonatas@teste.com',
#password: '123456', city: 'Osasco',
#state: 'Sao Paulo', phone: '123456')

category_hq = Category.create(name: 'HQs')
category_toy = Category.create(name: 'Brinquedos')
category_movie = Category.create(name: 'Filmes')
Category.create(name: 'Livros')                
Category.create(name: 'Jogos')
Category.create(name: 'Acessórios')
Category.create(name: 'Outros')

condition_great = Condition.create(name: 'Ótimo estado')
Condition.create(name: 'Bom estado')
Condition.create(name: 'Conservado')
Condition.create(name: 'Com poucas avarias')
condition_very_damaged = Condition.create(name: 'Com muitas avarias')


first_product = Product.create!(
  title: 'Filme A morte do Superman',
  description: 'Animação clássica de 1999',
  category: category_movie, price: '30,00',
  condition: condition_great, negotiation: :both, user: first_user,
  photo: File.new(Rails.root.join('spec', 'support',
                                  'filme_morte_do_superman.jpg'))
)

second_product = Product.create!(
  title: 'A morte do Superman HQ',
  description: 'HQ clássica de 1999',
  category: category_hq, price: '50,00',
  condition: condition_great, negotiation: :sale, user: first_user,
  photo: File.new(Rails.root.join('spec', 'support',
                                  'hq_morte_do_superman.jpg'))
)

third_product = Product.create!(
  title: 'HQ do Batman: Knight Fall',
  description: 'Rara HQ do Batman',
  category: category_hq, price: '1000,00',
  condition: condition_great, negotiation: :trade, user: second_user,
  photo: File.new(Rails.root.join('spec', 'support', 'knightfall.jpg'))
)

fourth_product = Product.create!(
  title: 'Robô megazord',
  description: 'Robô megazord lego',
  category: category_toy, price: '500,00',
  condition: condition_very_damaged, negotiation: :both, user: third_user,
  photo: File.new(Rails.root.join('spec', 'support', 'megazord_lego.jpg'))
)

Proposal.create(desired: third_product, receiver: second_user, 
                offered: second_product, sender: first_user,
                price: '900,00', 
                comment: 'Espero que aceite. Acho justo')

Proposal.create(desired: third_product, receiver: second_user, 
                offered: fourth_product, sender: third_user,
                price: '500,00', 
                comment: 'Aceita meu megazord aí amigão. Ele é raro',
                status: 2)

Proposal.create(desired: first_product, receiver: first_user, 
                offered: fourth_product, sender: third_user, 
                comment: 'Me volta 100 aí mano')
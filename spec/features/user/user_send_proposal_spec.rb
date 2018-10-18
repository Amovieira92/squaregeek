require 'rails_helper'

feature 'user send proposal' do
  scenario 'successfully' do
    hq_category = Category.create(name: 'HQs')

    condition = Condition.create(name: 'Rasgado')

    first_product = Product.create(
      title: 'HQ Injustice',
      description: 'Em capa dura',
      category: movie_category, price: '5,00',
      condition: condition, negotiation: :trade,
      photo: File.new(Rails.root.join('spec', 'support', 'injustice.jpg'))
    )

    visit root_path

    click_on 'HQ Injustice'

    click_on 'Negociar'

  end
end
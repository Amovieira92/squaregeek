class Proposal < ApplicationRecord

  belongs_to :sender, class_name: 'user'
  belongs_to :receiver, class_name: 'user'

  has_one :offered, class_name: 'product'
  belongs_to :desired, class_name: 'product'

  enum status [:pending, :accepted, :denied]
  enum negotiation [:trade, :sale, :both]

end

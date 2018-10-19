class Proposal < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :offered, class_name: 'Product', optional: true
  belongs_to :desired, class_name: 'Product'
  enum status: %i[pending accepted denied]
  enum negotiation: %i[trade sale both]

  def user_related?(user)
    [receiver, sender].include?(user)
  end
end

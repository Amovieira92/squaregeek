class Product < ApplicationRecord
  belongs_to :category
  belongs_to :condition
  has_attached_file :photo, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/products/missing.jpg'
  enum negotiation: %i[trade sale both]
end

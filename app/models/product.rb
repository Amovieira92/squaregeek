class Product < ApplicationRecord
  belongs_to :category
  belongs_to :condition
  has_attached_file :photo, styles: { medium: '600x600>', thumb: '300x300>' },
                            default_url: '/images/products/missing.jpg'
  validates_attachment_content_type :photo, content_type: %r{\Aimage\/.*\z}
  enum negotiation: { trade: 0, sale: 1, both: 2 }
end

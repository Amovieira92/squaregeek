class Product < ApplicationRecord
  belongs_to :category
  belongs_to :condition
  belongs_to :user
  has_attached_file :photo, styles: { medium: 'x300>', thumb: 'x100>' },
                            default_url: 'products/missing.jpg'
  validates_attachment_content_type :photo, content_type: %r{\Aimage\/.*\z}
  enum negotiation: { trade: 0, sale: 1, both: 2 }
  validates :title, :price, presence: true
end

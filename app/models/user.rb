class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :products, dependent: :destroy
  has_many :proposals, foreign_key: 'sender_id', inverse_of: 'sender',
                       dependent: :destroy
  validates :name, :phone, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

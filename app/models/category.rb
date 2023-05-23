class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates_uniqueness_of :name, on: :create, message: 'must be unique'
end

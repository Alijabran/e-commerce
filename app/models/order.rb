class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  enum status: %i[in_cart paid]
end

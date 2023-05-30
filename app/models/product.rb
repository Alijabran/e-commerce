class Product < ApplicationRecord
  belongs_to :category
  belongs_to :coupon, optional: true
  has_many_attached :images, dependent: true

  def self.search(search)
    if search
      where('title like :search OR id = :id', search: "%#{search}%", id: search.to_i)
    else
      all
    end
  end

  def self.to_csv
    attributes = %w[title price description status]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |product|
        csv << product.attributes.values_at(*attributes)
      end
    end
  end
end

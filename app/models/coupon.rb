class Coupon < ApplicationRecord
  has_many :products
  def self.search(search)
    if search
      where('name like :search OR id = :id', search: "%#{search}%", id: search.to_i)
    else
      all
    end
  end

  def self.to_csv
    attributes = %w[id name discount_value]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |coupon|
        csv << coupon.attributes.values_at(*attributes)
      end
    end
  end
end

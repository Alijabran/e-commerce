class Product < ApplicationRecord
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

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end
end

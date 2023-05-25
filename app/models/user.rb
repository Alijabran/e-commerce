class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  validates :password, presence: true, length: { minimum: 8 },
                       format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).{8,}\z/m,
                                 message: 'must include at least one lowercase letter, one uppercase letter, one number, and one special character' },
                       on: :create

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.to_csv
    attributes = %w[first_name last_name email]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end

  def self.search(search)
    if search
      where("CONCAT(first_name, ' ' , last_name) like :search OR email LIKE :search OR id = :id", search: "%#{search}%", id: search.to_i)
    else
      all
    end
  end
end

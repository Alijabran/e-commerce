class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :password, presence: true, length: { minimum: 8 },
                       format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).{8,}\z/m,
                                 message: 'must include at least one lowercase letter, one uppercase letter, one number, and one special character' },
                       on: :create

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search(search)
    if search
      where("CONCAT(first_name, ' ' , last_name) like :search OR email LIKE :search OR id = :id", search: "%#{search}%", id: search.to_i)
    else
      all
    end
  end
end

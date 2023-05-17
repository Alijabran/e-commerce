class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :password, presence: true, length: { minimum: 8 }
  validate :pass_valid

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def pass_valid
    return if password.blank?

    errors.add(:password, 'must include at least one uppercase letter') unless password.match?(/[A-Z]/)

    errors.add(:password, 'must include at least one lowercase letter') unless password.match?(/[a-z]/)

    errors.add(:password, 'must include at least one number') unless password.match?(/\d/)

    return if password.match?(/[!?"$%^&)]/)

    errors.add(:password, 'must include at least one special symbol (! " ? $ % ^ & )')
  end

  def self.search(search)
    if search
      where("CONCAT(first_name, ' ' , last_name) like :search OR email LIKE :search OR id = :id", search: "%#{search}%", id: search.to_i)
    else
      all
    end
  end
end

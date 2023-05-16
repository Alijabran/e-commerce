class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :password, presence: true, length: { minimum: 8 }
  validate :password_complexity

  private

  def password_complexity
    return if password.blank?

    unless password.match?(/[A-Z]/)
      errors.add(:password, 'must include at least one uppercase letter')
    end

    unless password.match?(/[a-z]/)
      errors.add(:password, 'must include at least one lowercase letter')
    end

    unless password.match?(/\d/)
      errors.add(:password, 'must include at least one number')
    end

    unless password.match?(/[!?"?$%^&)]/)
      errors.add(:password, 'must include at least one special symbol (! " ? $ % ^ & )')
    end

  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true

  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  with_options presence: true, format: { with: NAME_REGEX, message: 'Full-width characters' } do
    validates :family_name
    validates :first_name
  end

end

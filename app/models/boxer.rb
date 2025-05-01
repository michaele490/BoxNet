class Boxer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :coach, optional: true
  has_many :boxer_requests, dependent: :destroy

  WEIGHT_CLASSES = [
    "minimum",
    "light fly",
    "fly",
    "super fly",
    "bantam",
    "super bantam",
    "feather",
    "super feather",
    "light",
    "super light",
    "welter",
    "super welter",
    "middle",
    "super middle",
    "light heavy",
    "cruiser",
    "heavy"
  ]

  validates :weight_class, inclusion: { in: WEIGHT_CLASSES }, allow_nil: true
  validates :gender, inclusion: { in: ["Male", "Female"] }, allow_nil: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end
end

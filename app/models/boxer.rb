require 'countries'

class Boxer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :coach, optional: true
  has_many :boxer_requests, dependent: :destroy
  has_many :fights_as_a, class_name: 'Fight', foreign_key: 'boxer_a_id'
  has_many :fights_as_b, class_name: 'Fight', foreign_key: 'boxer_b_id'

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
  validates :nationality, inclusion: { in: ISO3166::Country.translations.values }, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def country_code
    return nil if nationality.blank?
    country_code = ISO3166::Country.translations.key(nationality)&.downcase
    country_code
  end

  def meters_to_feet_inches(meter_str)
    return "N/A" if meter_str.nil?
    meters = meter_str.to_f
    total_inches = (meters * 39.3701).round
    feet = total_inches / 12
    inches = total_inches % 12
    "#{feet}'#{inches}\""
  end

  def nationality_with_flag
    return "N/A" if nationality.blank?
    code = country_code
    return nationality unless code
    
    # Return HTML safe string with flag icon
    "<span class='fi fi-#{code} me-2'></span>#{nationality}".html_safe
  end

  def name_with_id
    "#{full_name} | (ID: #{id})"
  end

  def all_fights
    (fights_as_a + fights_as_b).uniq
  end
end

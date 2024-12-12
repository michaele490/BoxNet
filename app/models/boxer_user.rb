class BoxerUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # Creating boxer profile which is connected to their devise model
  after_create :create_boxer_profile

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true

  has_one :boxer, dependent: :destroy

  def create_boxer_profile
    Rails.logger.debug "create_boxer_profile method called for BoxerUser ID: #{id}"

    return if boxer.present?

    boxer = Boxer.new(
      first_name: first_name,
      last_name: last_name,
      boxer_user_id: id
    )

    if boxer.save
      Rails.logger.debug "Boxer profile created successfully for BoxerUser ID: #{id}"
    else
      Rails.logger.error "Failed to create boxer profile: #{boxer.errors.full_messages.join(', ')}"
    end
  rescue => e
    Rails.logger.error "Error creating boxer profile: #{e.message}"
  end
end

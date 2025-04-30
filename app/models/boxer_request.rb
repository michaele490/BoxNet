class BoxerRequest < ApplicationRecord
  belongs_to :coach
  belongs_to :boxer

  enum status: {
    pending: 0,
    accepted: 1,
    rejected: 2
  }

  validates :coach_id, uniqueness: { scope: :boxer_id, message: "has already sent a request to this boxer" }
  validate :boxer_not_already_assigned

  private

  def boxer_not_already_assigned
    if boxer&.coach.present?
      errors.add(:boxer, "is already assigned to a coach")
    end
  end
end

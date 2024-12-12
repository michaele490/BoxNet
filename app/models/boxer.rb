=begin
class Boxer < ApplicationRecord
  belongs_to :boxer_user
  belongs_to :coach_user,  optional: true

  validates :overall_rating, :defence, :power, :speed, :iq,
  numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }
  allow_nil: true
end
=end

class Boxer < ApplicationRecord
  belongs_to :boxer_user
  belongs_to :coach_user, optional: true

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :overall_rating, :defence, :power, :speed, :iq,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    },
    allow_nil: true
end

class Boxer < ApplicationRecord
  belongs_to :boxer_user

  validates :overall_rating, :defence, :power, :speed, :iq,
  numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }

  # Optional: You can add a method to update ratings
  def update_overall_rating
  self.overall_rating = (defence + power + speed + iq) / 4
  save
  end
end

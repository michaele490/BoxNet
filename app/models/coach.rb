class Coach < ApplicationRecord
  belongs_to :coach_user
  has_many :boxers, dependent: :nullify
end

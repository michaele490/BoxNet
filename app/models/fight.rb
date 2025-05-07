class Fight < ApplicationRecord

    belongs_to :editor
    belongs_to :boxer_a, class_name: "Boxer"
    belongs_to :boxer_b, class_name: "Boxer"

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
    validate :boxers_must_be_different

    def fight_location
        if city.present? && country.present?
            [city, country].join(', ')
        elsif city.present?
            city
        elsif country.present?
            country
        else
            'TBD'
        end
    end

    def opponent_for(boxer)
        boxer_a == boxer ? boxer_b : boxer_a
    end

    def boxer_in_question(boxer)
        boxer_a == boxer ? :a : :b
    end

    private
    
    def boxers_must_be_different
        if boxer_a == boxer_b
            errors.add(:boxer_b, "Boxers must be different")
        end
    end
    
    
end
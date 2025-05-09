class Fight < ApplicationRecord
    # A fight record where status == 'occurred' is a result
    # A fight record where status == 'scheduled' is a fixture
    
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

    after_initialize :set_default_status, if: :new_record?
    after_save :update_boxers_records
    after_destroy :update_boxers_records

    def fight_location
        computed_location = if city.present? && country.present?
            [city, country].join(', ')
        elsif city.present?
            city
        elsif country.present?
            country
        else
            'TBD'
        end
        if self.location != computed_location
          self.location = computed_location
          save!
        end
        computed_location
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
    
    def same_gender
        if boxer_a.gender != boxer_b.gender
            errors.add(:boxer_b, "Boxers must be of the same gender")
            alert("Boxers must be of the same gender")
        end
    end
    
    def set_default_status
      self.status ||= 'scheduled'
    end
    
    def update_boxers_records
      boxer_a.boxer_record&.update_record_stats!
      boxer_b.boxer_record&.update_record_stats!
    end
    
end
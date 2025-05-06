class Fight < ApplicationRecord
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
    
end
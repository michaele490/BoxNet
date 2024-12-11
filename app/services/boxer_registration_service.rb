class BoxerRegistrationService
  def self.create(boxer_user_params)
    boxer_user = BoxerUser.new(boxer_user_params)

    if boxer_user.save
      boxer_user.create_boxer!(
        overall_rating: 50,
        defence: 50,
        power: 50,
        speed: 50,
        iq: 50
      )
      boxer_user
    else
      nil
    end
  end
end

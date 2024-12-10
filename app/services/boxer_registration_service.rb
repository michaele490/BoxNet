class BoxerRegistrationService
  def self.create(boxer_user)
    boxer_user.create_boxer
    boxer_user
  end
end

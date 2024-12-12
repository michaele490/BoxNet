=begin
class BoxerRegistrationService
  def self.create(boxer_user_params)
    boxer_user = BoxerUser.new(boxer_user_params)
    if boxer_user.save
      boxer_user.create_boxer!
    end
  end
end
=end

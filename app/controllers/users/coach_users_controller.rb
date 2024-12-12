=begin
class Users::CoachUsersController < ApplicationController
  before_action :authenticate_coach_user!

  def assign_boxers
    @boxers = Boxer.where(coach_user: nil)
  end

  def assign_boxer
    @boxer = Boxer.find(params[:id])
    if @boxer.coach_user.nil? # Ensure the boxer isn't already assigned
      @boxer.update(coach_user: current_coach_user)
      redirect_to assign_boxers_coach_users_path, notice: "#{@boxer.name} has been assigned to you."
    else
      redirect_to assign_boxers_coach_users_path, alert: "#{@boxer.name} is already assigned to a coach."
    end
  end
end
=end

module Users
  class CoachUsersController < ApplicationController
    before_action :authenticate_coach_user!

    def assign_boxers
      @boxers = Boxer.where(coach_user: nil)
    end
  end
end

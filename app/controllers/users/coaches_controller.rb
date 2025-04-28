class Users::CoachesController < ApplicationController
  def assign_boxer
    @boxer = Boxer.find(params[:id])
    if @boxer.coach.nil? # Ensure the boxer isn't already assigned
      @boxer.update(coach: current_coach)
      redirect_to assign_boxers_coach_path, notice: "#{@boxer.name} has been assigned to you."
    else
      redirect_to assign_boxers_coach_path, alert: "#{@boxer.name} is already assigned to a coach."
    end
  end
end


module Users
  class CoachesController < ApplicationController
    before_action :authenticate_coach!

    def assign_boxers
      @boxers = Boxer.where(coach: nil)
    end
  end
end

class CoachesController < ApplicationController
  before_action :authenticate_coach!
  
  def profile
    @coach = current_coach
=begin
    @upcoming_fights = Fight.upcoming.joins(:boxer)
                          .where(boxers: { coach_id: current_coach.id })
                          .order(date: :asc)
                          .limit(10)
    
    @recent_results = Result.joins(:boxer)
                           .where(boxers: { coach_id: current_coach.id })
                           .order(date: :desc)
                           .limit(10)
=end
  end
end

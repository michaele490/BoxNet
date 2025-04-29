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

  def assign_boxers
    @boxers = Boxer.where(coach_id: nil)
    
    if params[:search].present?
      @boxers = @boxers.where("first_name ILIKE ? OR last_name ILIKE ?", 
                             "%#{params[:search]}%", 
                             "%#{params[:search]}%")
    end

=begin
    if params[:division].present? && params[:division] != "All"
      @boxers = @boxers.where(division: params[:division])
    end

    if params[:nationality].present? && params[:nationality] != "All"
      @boxers = @boxers.where(nationality: params[:nationality])
    end

    @divisions = Boxer.distinct.pluck(:division).compact
    @nationalities = Boxer.distinct.pluck(:nationality).compact
=end
  end

  def send_add_request
    @boxer = Boxer.find(params[:boxer_id])
    # Add request logic will be implemented later
    redirect_to assign_boxers_path, notice: "Request sent to #{@boxer.full_name}"
  end
end

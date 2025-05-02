class CoachesController < ApplicationController
  before_action :authenticate_coach!
  before_action :set_boxer, only: [:edit_boxer, :update_attributes]
  
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

  def edit_boxer
    # @boxer is set by before_action
  end

  def edit_profile
    @coach = current_coach
    @boxer = Boxer.find(params[:boxer_id])
  end

  def send_add_request
    @boxer = Boxer.find(params[:boxer_id])
    @request = current_coach.boxer_requests.build(boxer: @boxer)

    if @request.save
      redirect_to assign_boxers_path, notice: 'Request sent successfully!'
    else
      redirect_to assign_boxers_path, alert: @request.errors.full_messages.join(', ')
    end
  end

  def update_attributes
    if @boxer.update(boxer_params)
      redirect_to coach_profile_path(current_coach.id)
      puts "The coach has successfully updated the boxer's details!!!"
    else
      redirect_to edit_boxer_ratings_path(@boxer)
      puts "There was a failure in updating the boxer's attributes"
    end
  end

  def cancel_request
    @boxer = Boxer.find(params[:boxer_id])
    @request = current_coach.boxer_requests.find_by(boxer: @boxer, status: :pending)

    if @request&.destroy
      redirect_to assign_boxers_path, notice: 'Request canceled successfully!'
    else
      redirect_to assign_boxers_path, alert: 'Failed to cancel request.'
    end
  end

  private

  def set_boxer
    @boxer = Boxer.find(params[:boxer_id])
  end

  def boxer_params
    params.require(:boxer).permit(:overall_rating, :defence, :power, :speed, :iq, :height, :stamina)
  end
end

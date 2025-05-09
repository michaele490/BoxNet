class CoachesController < ApplicationController
  before_action :authenticate_coach!
  before_action :set_boxer, only: [:edit_boxer, :update_attributes]
  
  def profile
    @coach = current_coach
    boxer_ids = @coach.boxers.pluck(:id)
    @upcoming_fights = Fight.where(status: 'scheduled')
                            .where("boxer_a_id IN (?) OR boxer_b_id IN (?)", boxer_ids, boxer_ids)
                            .order(fight_date: :asc)
                            .limit(10)
    @recent_results = Fight.where(status: 'occurred')
                           .where("boxer_a_id IN (?) OR boxer_b_id IN (?)", boxer_ids, boxer_ids)
                           .order(fight_date: :desc)
                           .limit(10)
  end

  def assign_boxers
    @boxers = Boxer.where(coach_id: nil)

    if params[:division].present? && params[:division] != ""
      @boxers = @boxers.where(weight_class: params[:division])
    end

    if params[:nationality].present? && params[:nationality] != ""
      @boxers = @boxers.where(nationality: params[:nationality])
    end

    if params[:search].present?
      @boxers = @boxers.where("first_name ILIKE ? OR last_name ILIKE ? OR (first_name || ' ' || last_name) ILIKE ?", 
                              "%#{params[:search]}%", 
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

  def full_results
    @coach = current_coach
    boxer_ids = @coach.boxers.pluck(:id)
    @results = Fight.where(status: 'occurred')
                    .where("boxer_a_id IN (?) OR boxer_b_id IN (?)", boxer_ids, boxer_ids)
    # Filters
    if params[:date_from].present?
      @results = @results.where('fight_date >= ?', params[:date_from])
    end
    if params[:date_to].present?
      @results = @results.where('fight_date <= ?', params[:date_to])
    end
    if params[:division].present? && params[:division] != ""
      @results = @results.where(weight_class: params[:division])
    end
    if params[:gender].present? && params[:gender] != ""
      @results = @results.joins("LEFT JOIN boxers AS a ON fights.boxer_a_id = a.id LEFT JOIN boxers AS b ON fights.boxer_b_id = b.id")
                         .where("a.gender = :gender OR b.gender = :gender", gender: params[:gender])
    end
    @results = @results.order(fight_date: :desc)

    respond_to do |format|
      format.html
      format.js { render partial: 'coaches/results_list', locals: { results: @results, coach: @coach } }
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

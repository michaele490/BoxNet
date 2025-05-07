class BoxersController < ApplicationController
    before_action :authenticate_boxer!, only: [:details, :update_details]
    before_action :set_boxer, only: [:profile, :details, :update_details]

    def profile
      @boxer = Boxer.find(params[:id])
    end

    def details
    end

    def update_details
      if @boxer.update(boxer_params)
        redirect_to boxer_profile_path(@boxer), notice: 'Details updated successfully.'
      else
        render :details
      end
    end

    def remove
      @boxer = Boxer.find(params[:id])

      if (boxer_signed_in? && current_boxer == @boxer) || (coach_signed_in? && @boxer.coach == current_coach)
        # Remove the coach assignment
        BoxerRequest.find_by(boxer: @boxer, coach: @boxer.coach)&.destroy
        @boxer.update(coach: nil)
        if boxer_signed_in?
          redirect_to boxer_profile_path(@boxer), notice: "Coach has been removed."
          # puts "The intended condition was executed!!! Congratulations!"
        else
          redirect_to coach_profile_path, notice: "#{@boxer.full_name} has been removed from your boxers."
          # puts "The unintended condition was executed!!! Too bad!"
        end
      else
        redirect_back fallback_location: root_path, alert: "You are not authorized to perform this action."
      end
    end

    def autocomplete
      term = params[:term]
      boxers = Boxer.where("first_name ILIKE ? OR last_name ILIKE ? OR (first_name || ' ' || last_name) ILIKE ?", "%#{term}%", "%#{term}%", "%#{term}%").limit(10)
      render json: boxers.map { |b| { id: b.id, name: b.name_with_id } }
    end

    private

    def set_boxer
      @boxer = current_boxer
    end

    def boxer_params
      params.require(:boxer).permit(:nickname, :gender, :weight_class, :height, :reach, :nationality)
    end
end

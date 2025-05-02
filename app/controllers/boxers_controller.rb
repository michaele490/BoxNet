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
      
      if @boxer.coach == current_coach
        # Find and destroy the associated BoxerRequest
        BoxerRequest.find_by(boxer: @boxer, coach: current_coach)&.destroy
        
        @boxer.update(coach: nil)
        redirect_to coach_profile_path, notice: "#{@boxer.full_name} has been removed from your boxers."
      else
        redirect_to coach_profile_path, alert: "You are not authorized to remove this boxer."
      end
    end

    private

    def set_boxer
      @boxer = current_boxer
    end

    def boxer_params
      params.require(:boxer).permit(:nickname, :gender, :weight_class, :height, :reach, :nationality)
    end
end

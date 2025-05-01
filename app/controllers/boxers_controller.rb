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

    private

    def set_boxer
      @boxer = current_boxer
    end

    def boxer_params
      params.require(:boxer).permit(:nickname, :gender, :weight_class, :height, :reach, :nationality)
    end
end

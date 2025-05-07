class EditorsController < ApplicationController
    before_action :authenticate_editor!

    def manage_fixtures
        @fights = Fight.all
    end

    def manage_results
        @fights = Fight.all
    end

    def fights
        @fights = Fight.all
    end

=begin
    def create
        @fight = Fight.new(fight_params)
        if @fight.save
            redirect_to manage_fixtures_path, notice: 'Fight was successfully created.'
        else
            redirect_to manage_fixtures_path, alert: @fight.errors.full_messages.join(', ')
        end
    end


    private
    def fight_params
        params.require(:fight).permit(:boxer_a_id, :boxer_b_id, :fight_date, :weight_class, :country, :city)
    end
=end    
end

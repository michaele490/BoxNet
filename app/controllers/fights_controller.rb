class FightsController < ApplicationController
    def create
        @fight = Fight.new(fight_params)
        @fight.editor = current_editor
        Rails.logger.info "Fight params: \\#{fight_params.inspect}"
        if @fight.save
            redirect_to manage_fixtures_path, notice: 'Fight was successfully created.'
        else
            Rails.logger.error "Fight errors: \\#{@fight.errors.full_messages.inspect}"
            redirect_to manage_fixtures_path, alert: @fight.errors.full_messages.join(', ')
        end
    end

    def update
        @fight = Fight.find(params[:id])
        if @fight.update(fight_params)
            redirect_to manage_fixtures_path, notice: 'Fight was successfully updated.'
        else
            redirect_to manage_fixtures_path, alert: @fight.errors.full_messages.join(', ')
        end
    end

    def destroy
        @fight = Fight.find(params[:id])
        @fight.destroy
        redirect_to manage_fixtures_path, notice: 'Fight was successfully deleted.'
    end

    private
    def fight_params
        params.require(:fight).permit(
            :boxer_a_id, 
            :boxer_b_id, 
            :fight_date, 
            :weight_class, 
            :country, 
            :city,
            :status,
            :winner_id,
            :method,
            :draw
        )
    end
end



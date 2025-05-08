class EditorsController < ApplicationController
    before_action :authenticate_editor!

    def manage_fixtures
        @fights = Fight.includes(:boxer_a, :boxer_b).all

        if params[:date_from].present?
          @fights = @fights.where('fight_date IS NOT NULL AND fight_date >= ?', params[:date_from])
        end
        if params[:date_to].present?
          @fights = @fights.where('fight_date IS NOT NULL AND fight_date <= ?', params[:date_to])
        end
        if params[:division].present? && params[:division] != ""
          @fights = @fights.where(weight_class: params[:division])
        end

        # Filter by gender (either boxer_a or boxer_b matches)
        if params[:gender].present? && params[:gender] != ""
          @fights = @fights.select { |f| f.boxer_a.gender == params[:gender] || f.boxer_b.gender == params[:gender] }
        end

        # Filter by boxer name (either boxer_a or boxer_b matches)
        if params[:search].present? && params[:search] != ""
          search = params[:search].downcase
          @fights = @fights.select do |f|
            f.boxer_a.full_name.downcase.include?(search) || f.boxer_b.full_name.downcase.include?(search)
          end
        end
    end

    def manage_results
        @fights = Fight.includes(:boxer_a, :boxer_b).where(status: 'occurred')

        if params[:date_from].present?
          @fights = @fights.where('fight_date IS NOT NULL AND fight_date >= ?', params[:date_from])
        end
        if params[:date_to].present?
          @fights = @fights.where('fight_date IS NOT NULL AND fight_date <= ?', params[:date_to])
        end
        if params[:division].present? && params[:division] != ""
          @fights = @fights.where(weight_class: params[:division])
        end

        # Filter by gender (either boxer_a or boxer_b matches)
        if params[:gender].present? && params[:gender] != ""
          @fights = @fights.select { |f| f.boxer_a.gender == params[:gender] || f.boxer_b.gender == params[:gender] }
        end

        # Filter by boxer name (either boxer_a or boxer_b matches)
        if params[:search].present? && params[:search] != ""
          search = params[:search].downcase
          @fights = @fights.select do |f|
            f.boxer_a.full_name.downcase.include?(search) || f.boxer_b.full_name.downcase.include?(search)
          end
        end
    end

    def fights
        @fights = Fight.all
    end

    def create
        @fight = Fight.new(fight_params)
        @fight.editor = current_editor
        # Ensure status is 'occurred' for results
        @fight.status = 'occurred'
        # Handle draw logic
        if params[:fight][:winner_id] == 'draw'
          @fight.draw = true
          @fight.winner_id = nil
        else
          @fight.draw = false
        end
        if @fight.save
            redirect_to manage_results_path, notice: 'Result was successfully created.'
        else
            redirect_to manage_results_path, alert: @fight.errors.full_messages.join(', ')
        end
    end

    private
    def fight_params
        params.require(:fight).permit(:boxer_a_id, :boxer_b_id, :fight_date, :weight_class, :country, :city, :winner_id, :method, :draw, :status)
    end
end

class MainController < ApplicationController
    def index
    end

    def sign_up
    end

    def results
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
        if params[:gender].present? && params[:gender] != ""
            @fights = @fights.select { |f| f.boxer_a.gender == params[:gender] || f.boxer_b.gender == params[:gender] }
        end
        if params[:search].present? && params[:search] != ""
            search = params[:search].downcase.strip
            @fights = @fights.select do |f|
                f.boxer_a.full_name.downcase.include?(search) || f.boxer_b.full_name.downcase.include?(search)
            end
        end
        @fights = @fights.sort_by { |f| f.fight_date || Date.new(1900,1,1) }.reverse
    end

    def fixtures
        @fights = Fight.includes(:boxer_a, :boxer_b).where(status: 'scheduled')

        if params[:date_from].present?
            @fights = @fights.where('fight_date IS NOT NULL AND fight_date >= ?', params[:date_from])
        end
        if params[:date_to].present?
            @fights = @fights.where('fight_date IS NOT NULL AND fight_date <= ?', params[:date_to])
        end
        if params[:division].present? && params[:division] != ""
            @fights = @fights.where(weight_class: params[:division])
        end
        if params[:gender].present? && params[:gender] != ""
            @fights = @fights.select { |f| f.boxer_a.gender == params[:gender] || f.boxer_b.gender == params[:gender] }
        end
        @fights = @fights.sort_by { |f| f.fight_date || Date.new(1900,1,1) }.reverse
    end

    def test
        @fights = Fight.includes(:boxer_a, :boxer_b).where(status: 'occurred')
    end

    def boxers
        @boxers = Boxer.all

        # Apply filters
        @boxers = @boxers.where(weight_class: params[:division]) if params[:division].present?
        @boxers = @boxers.where(gender: params[:gender]) if params[:gender].present?
        @boxers = @boxers.where(nationality: params[:nationality]) if params[:nationality].present?

        # Order by name
        @boxers = @boxers.order(:first_name, :last_name)
    end

    def boxer_profile
    end
end

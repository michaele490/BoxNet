class MainController < ApplicationController
    def index
        # Featured Boxers: 3 random boxers with a nickname
        @featured_boxers = Boxer.includes(:boxer_record)
            .where.not(nickname: [nil, ''])
            .order(Arel.sql('RANDOM()'))
            .limit(3)

        # Recent Fights: 3 most recent occurred fights
        @recent_fights = Fight.includes(:boxer_a, :boxer_b)
            .where(status: 'occurred')
            .order(fight_date: :desc, created_at: :desc)
            .limit(3)

        # Top Knockout Artists: 3 boxers with most knockout wins
        @top_ko_boxers = Boxer.joins(:boxer_record)
            .select('boxers.*, boxer_records.knockout_wins')
            .order('boxer_records.knockout_wins DESC NULLS LAST')
            .limit(3)

        # Upcoming Events: 3 soonest scheduled fights
        @upcoming_fights = Fight.includes(:boxer_a, :boxer_b)
            .where(status: 'scheduled')
            .order(fight_date: :asc, created_at: :asc)
            .limit(3)

        # Ensure arrays for empty states
        @featured_boxers ||= []
        @recent_fights ||= []
        @top_ko_boxers ||= []
        @upcoming_fights ||= []
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

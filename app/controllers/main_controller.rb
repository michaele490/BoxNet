class MainController < ApplicationController
    def index
    end

    def sign_up
    end

    def results
        @fights = Fight.includes(:boxer_a, :boxer_b).where(status: 'occurred')

        if params[:division].present? && params[:division] != ""
            @fights = @fights.where(weight_class: params[:division])
        end

        if params[:gender].present? && params[:gender] != ""
            @fights = @fights.select { |f| f.boxer_a.gender == params[:gender] || f.boxer_b.gender == params[:gender] }
        end

        if params[:search].present? && params[:search] != ""
            search = params[:search].downcase
            @fights = @fights.select do |f|
                f.boxer_a.full_name.downcase.include?(search) || f.boxer_b.full_name.downcase.include?(search)
            end
        end

        @fights = @fights.sort_by { |f| f.fight_date || Date.new(1900,1,1) }.reverse
    end

    def fixtures
    end

    def test
        @fights = Fight.includes(:boxer_a, :boxer_b).where(status: 'occurred')
    end
end

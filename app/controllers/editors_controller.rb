class EditorsController < ApplicationController
    before_action :authenticate_editor!

    def manage_fixtures
        @fights = Fights.all
    end

    def manage_results
        @fights = Fights.all
    end

    def fights
        @fights = Fights.all
    end
end

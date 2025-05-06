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
end

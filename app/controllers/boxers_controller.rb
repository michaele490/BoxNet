class BoxersController < ApplicationController
    def profile
      @boxer = Boxer.find(params[:id])
    end
end

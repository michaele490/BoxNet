class BoxerRequestsController < ApplicationController
  before_action :authenticate_boxer!
  before_action :set_request, only: [:accept, :reject]

  def index
    @requests = current_boxer.boxer_requests.pending.includes(:coach)
  end

  def accept
    if @request.update(status: :accepted)
      @request.boxer.update(coach: @request.coach)
      redirect_to boxer_requests_path, notice: 'Request accepted successfully!'
    else
      redirect_to boxer_requests_path, alert: 'Failed to accept request.'
    end
  end

  def reject
    if @request.update(status: :rejected)
      redirect_to boxer_requests_path, notice: 'Request rejected successfully!'
    else
      # Redirecting to the root path so I can clearly see if the rejection has failed
      redirect_to root_path, alert: 'Failed to reject request.'
      puts "FOR WHATEVER REASON THIS REJECTION HAS FAILED!!!"
    end
  end

  private

  def set_request
    @request = current_boxer.boxer_requests.find(params[:id])
  end
end

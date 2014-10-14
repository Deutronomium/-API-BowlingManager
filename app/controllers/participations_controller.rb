class ParticipationsController < ApplicationController
  def index
    participations = Participation.all
    if event_id = params[:event_id]
      participations = participations.where(event_id: event_id)
    end
    if user_id = params[:user_id]
      participations = participations.where(user_id: user_id)
    end

    render json: participations, status: 200
  end
end
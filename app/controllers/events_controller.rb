class EventsController < ApplicationController

  def index
    events = Event.all
    if club_id = params[:club_id]
      events = events.where(club_id: club_id)
    end
    render json: events, status: 200
  end

  def create
    event = Event.create(event_params)
    if event.save
      render json: event, status: 201, location: event
    else
      render json: event.errors, status: 422
    end
  end

  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      render json: event, status: 200
    else
      render json: event.errors, status: 422
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy!
    render nothing: true, status: 204
  end

  def event_params
    params.require(:event).permit(:name, :club_id, :date)
  end

end
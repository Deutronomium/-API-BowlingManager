class EventsController < ApplicationController

  def index
    events = Event.all
    if club_id = params[:club_id]
      events = events.where(club_id: club_id)
    end
    render json: events, status: 200
  end

  def create
    event_name = event_params[:name]
    event_date = DateTime.parse(event_params[:date])
    club_id = event_params[:club_id]
    club = Club.find_by_id(club_id)
    event = Event.create(name: event_name, date: event_date.to_time, club_id: club_id)
    if !club.nil?
      club.users.each do |user|
        Participation.create!(event: event, user:user)
      end
    end
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
    begin
      event = Event.find(params[:id])
      event.destroy!
      render nothing: true, status: 204
    rescue ActiveRecord::RecordNotFound
      error = { error: { event: 'event not found' } }
      render json: error.to_json, status: 422
    end
  end

  def get_events_by_club
      club = Club.find_by_id(get_events_by_club_params[:club_id])
      if !club.nil?
        events = club.events
        render json: events, status: 200
      else
        error = { error: { club: 'club not found'} }
        render json: error.to_json, status: 422
      end
  end

  def get_participants
    event_id = get_participants_params[:event_id]
    event = Event.find(event_id)
    participants = event.participations.merge(Participation.participant)
    render json: participants, status: 200
  rescue ActiveRecord::RecordNotFound
    error = {error: {message: 'Event not found'}}
    render json: error, status: 404
  end

  def event_params
    params.require(:event).permit(:name, :club_id, :date)
  end

  def get_events_by_club_params
    params.require(:event).permit(:club_id)
  end

  def get_participants_params
    params.require(:event).permit(:event_id)
  end

end
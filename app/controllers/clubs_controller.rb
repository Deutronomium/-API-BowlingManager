class ClubsController < ApplicationController
  def index
    render json: Club.all, status: 200
  end
end
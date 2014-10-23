require 'spec_helper'
require 'club'

describe '#listing all clubs' do
  before do
    FactoryGirl.create(:club)
    FactoryGirl.create(:club, name: 'secondClub')

    get '/clubs'
  end

  it 'should respond wih success' do
    response.status.should eq(200)
  end

  it 'should respond with json' do
    response.content_type.should eq(Mime::JSON)
  end

  it 'should respond with 2 clubs' do
    clubs = json(response.body)[:clubs]
    clubs.size.should eq(Club.count)
  end

end
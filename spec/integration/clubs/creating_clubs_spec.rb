require 'spec_helper'

describe 'creating clubs' do

  context '#create club with valid data' do
    before do
      post ('/clubs'),
           { club: { name: 'Club' } }.to_json,
           { 'Accept' => 'application/json',
              'Content-Type' => 'application/json' }
    end

    it 'should respond with created' do
      response.status.should eq(201)
    end

    it 'should respond with json' do
      response.content_type.should eq(Mime::JSON)
    end

    it 'should respond with the correct location' do
      club = json(response.body)[:club]
      response.location.should eq(club_url(club[:id]))
    end
  end

  context '#create club with invalid data should report errors' do
    before do
      post ('/clubs'),
           { club: {
              name: nil 
           }}.to_json,
           { 'Accept' => 'application/json',
              'Content-Type' => 'application/json' }
    end

    it 'should respond with unprocessable entity' do
      response.status.should eq(422)
    end

    it 'should respond with errors for name' do
      errors = json(response.body)
      errors[:name].should_not be nil
    end
  end

end
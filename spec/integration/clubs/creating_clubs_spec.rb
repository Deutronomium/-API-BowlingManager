require 'spec_helper'

describe 'creating clubs' do

  context 'with valid data' do
    it 'should return the created club' do
      post ('/clubs'),
           {
               club: {
                   name: 'Club'
               }
           }.to_json,
           request_heders

      response.status.should eq(201)

      response.content_type.should eq(Mime::JSON)

      club = json(response.body)[:club]
      response.location.should eq(club_url(club[:id]))
    end


  end

  context 'with invalid data' do
    it 'should answer with an error message' do
      post ('/clubs'),
           {
               club: {
                   name: nil
               }
           }.to_json,
           request_heders

      response.status.should eq(422)

      response.content_type.should eq(Mime::JSON)

      errors = json(response.body)
      errors[:name].should_not be nil
    end
  end
end
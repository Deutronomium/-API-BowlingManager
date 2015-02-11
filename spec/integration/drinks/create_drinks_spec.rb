require 'spec_helper'

describe 'creating drinks' do
  before do
    @club = FactoryGirl.create(:club)
  end

  context 'with valid data' do
    it 'should succeed' do
      post '/drinks',
           {
               drink: {
                   name: 'Bier',
                   price: 2.30,
                   club_id: @club.id
               }
           }.to_json,
           request_headers

      response.status.should eq(201)

      response.content_type.should eq(Mime::JSON)

      drink = json(response.body)[:drink]
      drink[:name].should eq('Bier')
      drink[:price].should eq('2.3')
      drink[:club_id].should eq(@club.id)
    end
  end

  context 'with invalid data' do
    it 'should respond with unprocessable entity' do
      drink_name = 'Bier'
      FactoryGirl.create(:drink, name: drink_name)
      post '/drinks',
           {
               drink: {
                   name: drink_name,
                   price: 2.30,
                   club_id: @club.id
               }
           }.to_json,
           request_headers

      response.status.should eq(422)

      response.content_type.should eq(Mime::JSON)

      error = json(response.body)[:error]
      error[:message].should_not be nil
    end
  end
end
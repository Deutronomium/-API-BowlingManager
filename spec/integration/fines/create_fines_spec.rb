require 'spec_helper'

describe 'creating fine' do
  before do
    @club = FactoryGirl.create(:club)
  end

  context 'with valid data' do
    it 'should succeed' do
      post '/fines',
           {
               fine: {
                   name: 'Too Late',
                   amount: 5.00,
                   club_id: @club.id
               }
           }.to_json,
           request_headers

      response.status.should eq(201)

      response.content_type.should eq(Mime::JSON)

      fine = json(response.body)[:fine]
      fine[:name].should eq('Too Late')
      fine[:amount].should eq('5.0')
      fine[:club_id].should eq(@club.id)
    end
  end
end
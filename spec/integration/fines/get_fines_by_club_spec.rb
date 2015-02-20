require 'spec_helper'

describe 'getting all fines of a given club' do
  context 'with an existing club' do
    it 'should return success' do
      @club = FactoryGirl.create(:club)

      (0..4).each do |i|
        FactoryGirl.create(:fine, club_id: @club.id)
      end

      post '/fines/get_by_club',
          {
              fine: {
                  club_id: @club.id
              }
          }.to_json,
          request_headers

      response.status.should eq(200)

      response.content_type.should eq(Mime::JSON)

      fines_by_club = json(response.body)[:fines]
      fines_by_club.size.should eq(5)
    end
  end
end
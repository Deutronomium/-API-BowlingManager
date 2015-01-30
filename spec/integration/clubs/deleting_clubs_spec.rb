require 'spec_helper'

describe 'Deleting a club' do
  context 'with valid data' do
    it 'should change the club count by -1' do
      @club = FactoryGirl.create(:club, name: 'TestClub')

      delete ("clubs/#{@club.id}")

      response.status.should eq(204)

      Club.count.should eq(0)
    end
  end

  context 'which is not in the database' do
    it 'should not reduce the club count' do
      @club = FactoryGirl.create(:club, name: 'TestClub')
      club_count = Club.count
      delete ('clubs/123')

      response.status.should eq(422)

      error = json(response.body)[:error]
      error[:club].should_not be nil

      Club.count.should eq(club_count)
    end

  end

end
require 'spec_helper'

describe 'deleting clubs' do
  context 'deleting a club which can be found' do
    before do
      @club = FactoryGirl.create(:club, name: 'TestClub')
    end

    context 'deleting by id' do
      it 'should respond without content' do
        delete ("clubs/#{@club.id}")
        response.status.should eq(204)
      end
    end

    context 'deling by name' do
      it 'should respond without content' do
        post 'clubs/delete_by_name',
            {
              club: {
                name: 'TestClub' 
              }
            }.to_json,
            {
              'Accept' => 'application/json',
              'Content-Type' => 'application/json'
            }

        response.status.should eq(204)
      end
    end
        
  end

  context 'deleting a club which is not in the database' do
    before do
      @club = FactoryGirl.create(:club, name: 'TestClub')
      delete ("clubs/123")
    end

    it 'should respond with unprocessable entity' do
      response.status.should eq(422)
    end

    it 'should respond with a club error' do
      error = json(response.body)[:error]
      error[:club].should_not be nil
    end
  end

end
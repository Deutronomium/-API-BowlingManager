require 'spec_helper'

describe 'listing all events from given club' do
	before do
		@club = FactoryGirl.create(:club)

		FactoryGirl.create(:event, club_id: @club.id, name: 'Kegeln')
		FactoryGirl.create(:event, club_id: @club.id, name: 'Kegeln')
	end

	context 'return 2 events from the created club with a correct club id' do
		before do 
			post '/events/get_by_club',
				{
					event: {
						club_id: @club.id
					}
				}.to_json,
				{
					'Accept' => 'application/json',
					'Content-Type' => 'application/json'
				}
		end

		it 'should answer with success' do
			response.should be_success
		end

		it 'should answer with json' do
			response.content_type.should eq(Mime::JSON)
		end

		it 'should respond with 2 events' do
			events_from_json = json(response.body)
			events = events_from_json[:events]
			events.count.should eq(2)
		end
	end

	context 'return an error with a wrong club_id'
		before do
			post '/events/get_by_club',
				{
					event: {
						club_id: 100
					}
				}.to_json,
				{
					'Accept' => 'application/json',
					'Content-Type' => 'application/json'
				}
		end

		it 'should answer with record not found' do
			response.status.should eq(422)
		end

		it 'should answer with json' do
			response.content_type.should eq(Mime::JSON)
		end

		it 'should have an error message' do
			error = json(response.body)[:error]
			error[:club].should_not be nil
		end
end






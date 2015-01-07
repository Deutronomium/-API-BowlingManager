require 'spec_helper'

describe 'remove a friend from a club' do
	before do
		@club = FactoryGirl.create(:club)
		@user = FactoryGirl.create(:user, club_id: @club.id)
		@user2 = FactoryGirl.create(:user, club_id: @club.id)
		@count = Club.find_by_name(@club.name).users.count
	end

	context 'which exists in the database' do
		before do
			post '/friends/removeFriendFromClub',
				{
					friends: {
						user_name: @user.userName,
						club_name: @club.name
					} 
				}.to_json,
				{
						'Accept' => 'application/json',
						'Content-Type' => 'application/json'
			}
		end

		it 'should respond with status ok' do
			response.should be_success
		end

		it 'should respond with json' do
			expect(response.content_type).to eq(Mime::JSON)
		end

		it 'should respond with a success message' do
			message = json(response.body)[:success][:message]
			expect(message).to_not be_empty
		end

		it 'should reduce the user count by one after removing a user from a club' do
			expect(@club.users.count).to eq(@count - 1)
		end
	end

	context 'which does not exis in the database' do
		before do
			post '/friends/removeFriendFromClub',
				{
					friends: {
						user_name: 'I do not exist in database',
						club_name: @club.name
					}
				}.to_json,
				{
					'Accpet' => 'application/json',
					'Content-Type' => 'application/json'
				}
		end

		it 'should answer with unprocessable entity' do
			expect(response.status).to eq(422)
		end

		it 'should answer with json' do
			expect(response.content_type).to eq(Mime::JSON)
		end

		it 'should respond with an error message' do
			message = json(response.body)[:error][:message]
			expect(message).to_not be_empty
		end

		it 'should not reduce the user count of the club' do
			expect(@club.users.count).to eq(2)
		end
	end
	
end
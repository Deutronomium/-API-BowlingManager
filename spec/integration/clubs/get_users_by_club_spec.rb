require 'spec_helper'

describe 'listing all users from a club' do
	before do
		@findClub = FactoryGirl.create(:club, name: 'TestClub')
		@notFindClub = FactoryGirl.create(:club, name: 'NotFindClub')

		FactoryGirl.create(:user, user_name: 'TrueUser1', club_id: @findClub.id)
		FactoryGirl.create(:user, user_name: 'TrueUser2', club_id: @findClub.id)

		FactoryGirl.create(:user, club_id: @notFindClub.id)
		FactoryGirl.create(:user, club_id: @notFindClub.id)
	end

	context 'club exists in the database' do
		before do			
			post 'clubs/get_members_by_club',
				{ club: {
					name: 'TestClub'
				  }  
				}.to_json,
				{
					'Accept' => 'application/json',
					'Content-Type' => 'application/json'
				}
		end

		context 'answer type' do
			it 'should respond with ok' do
				response.should be_success
			end

			it 'should respond with json' do
				response.content_type.should eq(Mime::JSON)
			end
		end

		context 'answer content' do
			let(:users) { (json(response.body)[:clubs]) }

			it 'should respond with 2 users' do
				users.size.should eq(2)
			end

			it 'should respond with the right users' do
				trueUser1 = users.first
				trueUser2 = users.last

				trueUser1[:user_name].should eq('TrueUser1')
				trueUser2[:user_name].should eq('TrueUser2')
			end
		end
	end

	context 'club does not exist in the database' do
		before do
			post 'clubs/get_members_by_club',
				{
					club: {
						name: 'ClubNotInDatabase'
					}
				}.to_json,
				{
					'Accept' => 'application/json',
					'Content-Type' => 'application/json'
				}
		end

		context 'answer typ' do
			it 'should respond with unprocessable entity' do
				response.status.should eq(422)
			end

			it 'should respond with json' do
				response.content_type.should eq(Mime::JSON)
			end
		end

		context 'answer content' do
			it 'should answer with an error' do
				error = json(response.body)[:error]
      			error[:info].should_not be nil
      		end
      	end
	end
	
end
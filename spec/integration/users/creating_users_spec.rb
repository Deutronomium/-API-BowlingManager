require 'spec_helper'

describe 'creating users' do
  before do
    @club = FactoryGirl.create(:club)
  end

  context '#creating user with valid data should succeed' do
    before do
      post '/users',
        { user: {
          userName: 'Deutro',
          firstName: 'Patrick',
          lastName: 'Engelkes',
          email: 'patrick.engelkes@gmail.com',
          street: 'Friedenstraße 149',
          club_id: @club.id,
          city: 'Rheine',
          password: 'test',
          password_confirmation: 'test'
      } }.to_json,
           { 'Accept' => 'application/json',
             'Content-Type' => 'application/json' }
    end

    context '#answer type' do
      it 'should answer with a 201 status code' do
        response.status.should eq(201)
        #expect(response.status).to eq(201)
      end

      it 'should answer with json' do
        response.content_type.should eq(Mime::JSON)
        #expect(response.content_type).to eq(Mime::JSON)
      end
    end

    context '#answer content' do
      let(:user) { (json(response.body)[:user]) }

      it 'should respond with the correct user location' do
        user_url(user[:id]).should eq(response.location)
      end

      it 'should respond with the correct user fields' do
        user[:userName].should eq('Deutro')
        user[:firstName].should eq('Patrick')
        user[:lastName].should eq('Engelkes')
        user[:email].should eq('patrick.engelkes@gmail.com')
        user[:street].should eq('Friedenstraße 149')
        user[:club_id].should eq(1)
        user[:city].should eq('Rheine')
      end
    end
  end

  context '#creating user with invalid data should fail' do
    it 'should answer with response code 422' do
      post '/users', { user: {
          userName: nil,
          firstName: 'Patrick',
          lastName: 'Engelkes',
          password: 'test',
          password_confirmation: 'test',
          email: 'test@test.de'
      } }.to_json,
           { 'Accept' => 'application/json',
             'Content-Type' => 'application/json' }

      response.status.should eq(422)
    end
  end
end
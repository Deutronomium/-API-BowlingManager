require 'spec_helper'

describe 'creating users' do
  before do
    @club = FactoryGirl.create(:club)
  end

  context 'with valid data' do
    it 'should succeed' do
      post '/users',
           {
               user: {
                   userName: 'Deutro',
                   firstName: 'Patrick',
                   lastName: 'Engelkes',
                   email: 'patrick.engelkes@gmail.com',
                   street: 'Friedenstraße 149',
                   club_id: @club.id,
                   city: 'Rheine',
                   password: 'test',
                   password_confirmation: 'test',
                   phone_number: '0111111111'
               }
           }.to_json,
           request_headers

      response.status.should eq(201)

      response.content_type.should eq(Mime::JSON)

      user = json(response.body)[:user]
      user_url(user[:id]).should eq(response.location)
      user[:userName].should eq('Deutro')
      user[:firstName].should eq('Patrick')
      user[:lastName].should eq('Engelkes')
      user[:email].should eq('patrick.engelkes@gmail.com')
      user[:street].should eq('Friedenstraße 149')
      user[:club_id].should eq(@club.id)
      user[:city].should eq('Rheine')
    end

  end

  context 'with invalid data should fail' do
    it 'should answer with an error message' do
      post '/users',
           {
               user: {
                   userName: nil,
                   firstName: 'Patrick',
                   lastName: 'Engelkes',
                   password: 'test',
                   password_confirmation: 'test',
                   email: 'test@test.de'
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

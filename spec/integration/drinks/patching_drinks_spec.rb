require 'spec_helper'

describe 'patching drinks' do
  context 'updating drink with valid data' do
    it 'should succeed' do
      @club = FactoryGirl.create(:club)
      @drink = FactoryGirl.create(:drink, club_id: @club.id)

      patch ("/drinks/#{@drink.id}"),
          {
              drink: {
                  name: 'Patch'
              }
          }.to_json,
          {
              'Accept' => Mime::JSON,
              'Content-Type' => Mime::JSON.to_s
          }

      response.status.should eq(200)

      @drink.reload.name.should eq('Patch')
    end
  end

  context 'updating drink with invalid data' do
    it 'should respond with unprocessable entity' do
      @club = FactoryGirl.create(:club)
      @drink = FactoryGirl.create(:drink, club_id: @club.id)

      patch ("/drinks/#{@drink.id}"),
            {
                drink: {
                    name: nil
                }
            }.to_json,
            {
                'Accept' => Mime::JSON,
                'Content-Type' => Mime::JSON.to_s
            }

      response.status.should eq(422)

      error = json(response.body)
      error[:name].should eq(["can't be blank"])
    end
  end


end
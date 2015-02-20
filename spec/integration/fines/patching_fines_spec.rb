require 'spec_helper'

describe 'patching fines' do
  context 'with valid data' do
    it 'should succeed' do
      @club = FactoryGirl.create(:club)
      @fine = FactoryGirl.create(:fine, club_id: @club.id)

      post ("/fines/#{@fine.id}"),
          {
              fine: {
                  name: 'Patch'
              }
          }.to_json,
          patch_header

      response.status.should eq(200)

      @fine.reload.name.should eq('Patch')
    end
  end

  context 'with invalid data' do
    it 'should respond with unprocessable entity' do
      @club = FactoryGirl.create(:club)
      @fine = FactoryGirl.create(:fine, club_id: @club.id)

      post ("fines/#{@fine.id}"),
          {
              fine: {
                  name: nil
              }
          }.to_json,
          patch_header

      response.status.should eq(422)

      error = json(response.body)
      error[:name].should eq(["can't be blank"])
    end
  end
end
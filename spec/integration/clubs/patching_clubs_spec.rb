require 'spec_helper'

describe '#patching clubs' do
  let(:club) { FactoryGirl.create(:club) }

  context '#updating club with valid data do' do
    before do
      patch ("/clubs/#{club.id}"),
            { club: { name: 'Patch' } }.to_json,
            { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    end

    it 'should respond with success' do
      response.status.should eq(200)
    end

    it 'should respond with json' do
      response.content_type.should eq(Mime::JSON)
    end

    it 'should update the club name' do
      club.reload.name.should eq('Patch')
    end
  end

  context '#updating club with invalid data' do
    before do
      patch ("/clubs/#{club.id}"),
            { club: { name: nil } }.to_json,
            { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    end

    it 'should respond with unprocessable entity' do
      response.status.should eq(422)
    end

    it 'should have an error for name' do
      error = json(response.body)
      error[:name].should_not be nil
    end
end
end
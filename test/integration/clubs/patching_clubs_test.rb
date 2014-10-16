require 'test_helper'

class PatchingClubsTest < ActionDispatch::IntegrationTest
  setup { @club = FactoryGirl.create(:club)}

  test 'updating club with valid data' do
    patch ("/clubs/#{@club.id}"),
          { club: { name: 'Patch' } }.to_json,
          { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 200, response.status
    assert_equal 'Patch', @club.reload.name
  end

  test 'updating club with too short username' do
    patch ("/clubs/#{@club.id}"),
          { club: { name: 'Pa' } }.to_json,
          { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
  end
end

require 'test_helper'

class CreatingClubsTest < ActionDispatch::IntegrationTest
  test 'creates new club with valid data' do
    post '/clubs',
         { club: {
             name: 'Glühwürmchen'
            }
         }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    club = json(response.body)[:club]
    assert_equal club_url(club[:id]), response.location

    assert_equal 'Glühwürmchen', club[:name]
  end

  test 'does not create club with invalid data' do
    post '/clubs',
         { club: {
            name: nil
            }
         }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end
end

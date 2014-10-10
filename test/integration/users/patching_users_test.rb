require 'test_helper'

class PatchingUsersTest < ActionDispatch::IntegrationTest
  setup { @user = User.create(userName: 'Deutro', firstName: 'Patrick', lastName: 'Engelkes') }

  test 'updating user' do
    patch ("/users/#{@user.id}"),
          { user: { userName: 'Patch', firstName: 'Test', lastName: 'Test' } }.to_json,
          { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 200, response.status
    assert_equal 'Patch', @user.reload.userName
  end

  test 'unsuccessful update on short userName' do
    patch ("/users/#{@user.id}"),
          { user: { userName: 'Pa', firstName: 'Test', lastName: 'Test' } }.to_json,
          { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
  end
end

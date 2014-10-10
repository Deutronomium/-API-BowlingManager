require 'test_helper'

class DeletingUsersTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(userName: 'Deutro', firstName: 'Patrick', lastName: 'Engelkes')
  end

  test 'delete users' do
    delete "/users/#{@user.id}"

    assert_equal 204, response.status
  end
end

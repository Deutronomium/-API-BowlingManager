require 'test_helper'

class DeletingUsersTest < ActionDispatch::IntegrationTest
  setup do
    @Deutro = User.create!(userName: 'Deutro', firstName: 'Patrick', lastName: 'Engelkes')
  end

  test 'delete users' do
    delete "/users/#{@Deutro.id}"

    assert_equal 204, response.status
  end
end

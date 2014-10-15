require 'test_helper'

class DeletingUsersTest < ActionDispatch::IntegrationTest
  setup do
    @Deutro = User.create!(userName: 'Deutro', firstName: 'Patrick', lastName: 'Engelkes', password: 'test', password_confirmation: 'test', email: 'test@test.de')
  end

  test 'delete users' do
    delete "/users/#{@Deutro.id}"

    assert_equal 204, response.status
  end
end

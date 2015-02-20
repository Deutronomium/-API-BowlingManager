#create clubs
@test_club = Club.create!(name: "TestClub");

@user = User.create!(user_name: 'Deutro', firstName: 'Patrick', lastName: 'Engelkes',
                        email: 'Test', password: 'test123', password_confirmation: 'test123',
                        phone_number: '0111111111', club_id: @test_club.id)

@event = Event.create!(name: 'Event', club_id: @test_club.id, date: Date.current)

Participation.create!(user_id: @user.id, event_id: @event.id, accept:true)

User.create!(user_name: 'Test1', firstName: 'Test1', lastName: 'Test1', phone_number: '11111', email: 'Test1',
              password: 'test', password_confirmation: 'test', club_id: @test_club.id)
User.create!(user_name: 'Test2', firstName: 'Test2', lastName: 'Test2', phone_number: '22222', email: 'Test2',
             password: 'test', password_confirmation: 'test', club_id: @test_club.id)
User.create!(user_name: 'Test3', firstName: 'Test3', lastName: 'Test3', phone_number: '33333', email: 'Test3',
             password: 'test', password_confirmation: 'test', club_id: @test_club.id)
User.create!(user_name: 'Test4', firstName: 'Test4', lastName: 'Test4', phone_number: '44444', email: 'Test4',
             password: 'test', password_confirmation: 'test')
User.create!(user_name: 'Test5', firstName: 'Test5', lastName: 'Test5', phone_number: '55555', email: 'Test5',
             password: 'test', password_confirmation: 'test')
User.create!(user_name: 'Test6', firstName: 'Test6', lastName: 'Test6', phone_number: '66666', email: 'Test6',
             password: 'test', password_confirmation: 'test')
User.create!(user_name: 'Test7', firstName: 'Test7', lastName: 'Test7', phone_number: '77777', email: 'Test7',
             password: 'test', password_confirmation: 'test')
User.create!(user_name: 'Test8', firstName: 'Test8', lastName: 'Test8', phone_number: '88888', email: 'Test8',
             password: 'test', password_confirmation: 'test')
User.create!(user_name: 'Test9', firstName: 'Test9', lastName: 'Test9', phone_number: '99999', email: 'Test9',
             password: 'test', password_confirmation: 'test')
User.create!(user_name: 'Test10', firstName: 'Test10', lastName: 'Test10', phone_number: '1010101010', email: 'Test10',
             password: 'test', password_confirmation: 'test')



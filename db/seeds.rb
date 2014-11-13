#create clubs
@glühwürmchen = Club.create!(name: "Glühwürmchen");

@patrick = User.create!(userName: 'Deutro', firstName: 'Patrick', lastName: 'Engelkes', email: 'patrick.engelkes@gmail.com',
  password: 'test123', password_confirmation: 'test123', phone_number: '0111111111')

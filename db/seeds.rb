# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = User.create(
  [
    {first_name: 'David',last_name: 'Espino', email: 'david@mail.com', password: 'password', is_admin: true},
    {first_name: 'Elena',last_name: 'Garcia', email: 'elena@mail.com', password: 'password', is_admin: true},
    {first_name: 'José',last_name: 'Hernandez', email: 'jose@mail.com', password: 'password'}
  ]
)

school = School.create(name: 'Walter C. Buchanan', code: 'BUCH2023')

student_one = Student.create(
  first_name: 'Jose',
  last_name: 'Rodriguez',
  active: true, 
  user: User.first, 
  school: school
)

school_year = SchoolYear.create(name: '2023-2024')

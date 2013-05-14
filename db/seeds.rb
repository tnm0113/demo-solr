# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5000.times do
  Company.create!( name:        Faker::Company.name,
                   email:       Faker::Internet.email,
                   address:     Faker::Address.street_address,
                   city:        Faker::Address.city,
                   country:     Faker::Address.country,
                   phone:       Faker::PhoneNumber.phone_number,
                   description: Faker::Lorem.sentences(5).join(' ')
                  )
end
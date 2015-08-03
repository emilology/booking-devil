# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Creating tables
Table.create(number:1, seats:4)
Table.create(number:2, seats:4)
Table.create(number:3, seats:2)
Table.create(number:4, seats:2)
Table.create(number:5, seats:4)
Table.create(number:6, seats:2)
Table.create(number:7, seats:8)

# Building combinations
t2 = Table.find(2)
t2.combination = Table.find(3)
t2.save

t2 = Table.find(3)
t2.combination = Table.find(2)
t2.save

t2 = Table.find(5)
t2.combination = Table.find(6)
t2.save

t2 = Table.find(6)
t2.combination = Table.find(5)
t2.save

Admin.create(email: "admin@hillsidekitchen.co.nz", password: ENV['AdminPassword'])

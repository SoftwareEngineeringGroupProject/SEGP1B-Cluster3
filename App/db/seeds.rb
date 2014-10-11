# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: "administrator", email: "admin@admin.com", password: "cluster3", password_confirmation: "cluster3", fname: "Default", lname: "Admin", companyname: "Cluster 3", address: "NA", phone: "NA", website: "NA", acctype: "coordinator")

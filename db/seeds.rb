# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.destroy_all

User.create(username: "admin",email: "admin@gmail.com", password: 12345678, scope: 'admin')
User.create(username: "tao",email: "tao@gmail.com", password: 12345678, scope: 'user')
User.create(username: "truong",email: "truong@gmail.com", password: 12345678, scope: 'user')
User.create(username: "thuan",email: "thuan@gmail.com", password: 12345678, scope: 'user')
User.create(username: "vinh",email: "vinh@gmail.com", password: 12345678, scope: 'user')
@admin = User.find_by({scope: 'admin'})

Company.destroy_all
@admin.companies.create{id: 10, user_id: 2, name: "ZALORA Group", logo: "zalora-group-logo-170-151.jpg", cover: "zalora-group-headline-photo-compress.jpg", overview: "<div><br>ZALORA Group is Asia Pacific’s leading gr...", employees: 1000, website: "https://itviec.com/companies/zalora-group", address: "District 4, Ho Chi Minh", estabish: 1000, investment: 1000, rank: 0.0})
@admin.companies.create{id: 9, user_id: 2, name: "NashTech", logo: "nashtech-logo-170-151.png", cover: "nashtech-headline-photo-compress.jpg", overview: "<div><br><strong>Global software, offshore develop...", employees: 1000, website: "", address: " Tan Binh, Ho Chi Minh", estabish: 1000, investment: 1000, rank: 0.0})
@admin.companies.create{id: 8, user_id: 2, name: "Framgia Inc.", logo: "framgia-inc-logo-170-151.png", cover: "framgia-inc-headline-photo-crop.jpg", overview: "<div><br></div><div><strong>One of the leading tec...", employees: 1000, website: "https://itviec.com/companies/framgia-inc", address: "Ha Noi, Ho Chi Minh, Da Nang", estabish: 1000, investment: 1000, rank: 0.0})
@admin.companies.create{id: 7, user_id: 2, name: "FPT Software", logo: "fpt-software-logo-170-151.png", cover: "fpt-software-headline-photo-compress.jpg", overview: "<div><br><strong>The leading provider of software ...", employees: 1000, website: "https://itviec.com/companies/fpt-software", address: "Ho Chi Minh, HaNoi, Da Nang", estabish: 1000, investment: 1000, rank: 0.0})
@admin.companies.create{id: 5, user_id: 2, name: "Luxoft Vietnam", logo: "luxoft-vietnam-logo-170-151.png", cover: "luxoft-vietnam-headline-photo-compress.jpg", overview: "<div><br>Our Values: Excellence, Commitment, Relat...", employees: 1000, website: "https://itviec.com/companies/luxoft-vietnam", address: "District 11, Ho Chi Minh", estabish: 1000, investment: 1000, rank: 0.0})

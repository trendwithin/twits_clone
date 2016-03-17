# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
User.create(email: 'test_admin@example.com', password: 'password', password_confirmation: 'password', role: 'admin')
User.create(email: 'me@you.com', password: 'password', password_confirmation: 'password')

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@twits.org"
  password = 'password'
  User.create!(email: email, password: password, password_confirmation: password)
end

# Blogs

Blog.create(title: 'First Title', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolorum velit numquam harum voluptates amet. Veniam voluptate magni, iste et perferendis officiis architecto adipisci corrupti autem laborum quidem magnam reprehenderit quibusdam!', user_id: User.first.id)
Blog.create(title: 'Second Blog', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam repellendus eveniet cum architecto explicabo unde ex deleniti culpa perferendis quidem aspernatur mollitia, numquam, iusto recusandae velit sed eaque omnis a!', user_id: User.first.id)
Blog.create(title: 'Third Blog', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Labore numquam quasi impedit accusamus quod soluta animi, nisi eveniet voluptas nam temporibus sint suscipit inventore est eaque expedita incidunt nostrum id!', user_id: User.first.id)
Blog.create(title: 'Fourth Blog', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga itaque molestias, ullam asperiores neque optio. Hic deserunt at cumque ipsum saepe, dolores similique quod in obcaecati mollitia accusamus culpa molestiae?', user_id: User.first.id)
Blog.create(title: 'Fifth Blog' , body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores veniam, iste eligendi nam ab, ipsum in et illum assumenda praesentium, optio placeat! Nobis repellendus quibusdam modi, quo iure perspiciatis suscipit!', user_id: User.first.id)
Blog.create(title: 'Sixth Blog', body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolorum, ipsum saepe labore, ipsa harum cum minima modi magnam repudiandae sit neque unde itaque mollitia quia enim. Aliquid omnis repellendus, aspernatur?', user_id: User.first.id)

# Chrips
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.chirps.create!(content: content) }
end

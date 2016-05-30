15.times do
  product = Product.create!(
    name: Faker::Hacker.noun,
    image_url: Faker::Avatar.image,
    description: Faker::Lorem.paragraph,
    inventory_quantity: rand(1..20),
    price: rand(5.0..500.0).round(2)
  )

  product.categories.create!(
    name: Faker::Book.genre
  )
end

# Create Initial User
tom = User.create!(
  username: "tom",
  email: "tom@tom.com",
  password: "tomtom"
)

# Create Admin
tim = User.create!(
  username: "tim",
  email: "tim@tim.com",
  password: "timtim",
  admin: true
)



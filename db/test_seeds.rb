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
kim = User.create!(
  username: "kim",
  email: "kim@kim.com",
  password: "kimkim"
)

# Create Admin
admin = User.create!(
  username: "admin",
  email: "admin@admin.com",
  password: "adminadmin",
  admin: true
)



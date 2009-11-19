require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.name  { Faker::Name.name }
Sham.email { Faker::Internet.email }
Sham.description  { Faker::Lorem.paragraph }

Restaurant.blueprint do
  name { Faker::Company.name }
  manager
end

Contact.blueprint do
  restaurant
end

ProductType.blueprint do
  restaurant
  name
end

Product.blueprint do
  restaurant
  product_type
  name
  description
  price { rand(50) + 0.01 }
end

OrderItem.blueprint do
  product
  order
  quantity { rand(9) + 1 }
  discount { rand }
end

Order.blueprint do
  restaurant
  discount {rand}
end

User.blueprint do
  username { Sham.name }
  email
  password { "test" }
  password_confirmation { password }
  active { true }
  admin {false}

  #this is all needed so we can log in for functional tests
  password_salt {Authlogic::Random.hex_token }
  crypted_password { Authlogic::CryptoProviders::Sha512.encrypt(password + password_salt) }
  persistence_token { Authlogic::Random.hex_token }
  single_access_token { Authlogic::Random.friendly_token }
  perishable_token { Authlogic::Random.friendly_token }
end


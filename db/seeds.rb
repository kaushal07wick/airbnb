# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Property.create!({
    name: 'Vialla',
    description: "excellent",
    headline: "best",
    address_1: "best",
    address_2: "best",
    city: "best",
    state: "best",
    country: "best",
})


Property.create!({
    name: 'Vial',
    description: "ecellent",
    headline: "bet",
    address_1: "bst",
    address_2: "best",
    city: "gk",
    state: "besvhlt",
    country: "best",
})

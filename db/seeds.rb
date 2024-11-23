require 'open-uri'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
description = <<-DESCRIPTION
<h1 class="font-medium">Hi. It&rsquo;s me, Seth!</h1>
<div>If you&rsquo;re reading this, you&rsquo;re considering booking a night at the Houseplant-inspired retreat. What makes it Houseplant-y, you may be asking? Well, it&rsquo;s stocked with some of our favourite Housegoods (even a pre-release copy of our NEW Vinyl Box Set Vol. 2!). The mid-century styling and LA views also have a distinctly Houseplant feel. And there&rsquo;s the fact that I&rsquo;ll be there to welcome you which, given that I&rsquo;m the founder, adds to the Houseplant-ness. I AM HOUSEPLANT!!!</div>
<h2 class="font-medium">What you&rsquo;ll do</h2>
<p>This mid-century modern space is an ideal getaway if you&rsquo;re looking for inspiration or just for a good hangout. There&rsquo;s also a pottery wheel there.<br />During your stay, you will get a glimpse into my creative process with opportunities to:<br />&ndash; Throw some pottery with ME in the in-house studio. I&rsquo;m a pretty good teacher!<br />&ndash; Take in the sun, the view and the setting, all equally good whether you&rsquo;re looking to be relaxed or inspired.<br />&ndash; Listen to Vol. 2 of our Vinyl Box Set before it comes out. Three vinyl records with tracklists curated by me and Evan Goldberg to match whatever mood you&rsquo;re in.<br />&ndash; Enjoy a fully stocked fridge, by which I mean go ahead and destock it/eat it all.<br />Booking opens for US residents at 10.00am PT on 7 Feb for three one-night stays on 15, 16 and 17 Feb.<br />Also, as part of our collaboration with Airbnb, they&rsquo;ll be making a one-time donation to Hilarity for Charity, a national non-profit on a mission to care for families affected by Alzheimer&rsquo;s disease, to activate the next generation of Alzheimer&rsquo;s advocates and to be a leader in brain health research and education.</p>
<h4>Other things to note</h4>
<div>Following arrival and check-in, our on-site concierge will help ensure a comfortable stay.<br />Following public health guidance, guests and on-site staff are required to comply with local rules regarding COVID-19 as well as Airbnb&rsquo;s COVID-19 Safety Practices.<br />These one-night stays are not a contest. Guests are responsible for their own travel to and from Los Angeles. This home is privately owned and operated. No cannabis-based products will be made available or provided to guests during the stays.
Listing is not available for booking by nationalities prohibited by local law.</div>
<h4 class="font-medium">Registration number</h4>
<p>HSR22-004196</p>
DESCRIPTION


ameneties_data = [
    {name: 'kitchen', icon: "kitchen.svg", description: "Private Kitchen"},
    {name: 'ac', icon: "ac.svg", description: "Air Conditioner"},
    {name: 'parking', icon: "parking.svg", description: "Dedicated Parking"},
    {name: 'tv', icon: "tv.svg", description: "TV with Netflix"},
    {name: 'wifi', icon: "wifi.svg", description: "Wifi"},
]

ameneties_data.each do |data|
    amenity = Amenity.create!(name: data[:name], description: data[:description])
    amenity.icon.attach(io: File.open("app/assets/images/amenity_icons/#{data[:icon]}"), filename: amenity.name)
end

pictures = []
20.times do 
    pictures << URI.parse(Faker::LoremFlickr.image).open
end

user = User.create!({
    email: 'test1@gmail.com',
    password: '123456',
    name: Faker::Lorem.unique.sentence(word_count: 3),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,  
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
})

user.picture.attach(io: pictures[0], filename: user.name)

19.times do |i|
    random_user = User.create!({
        email: "test#{i + 2}@gmail.com",
        password: '123456',
        name: Faker::Lorem.unique.sentence(word_count: 3),
        address_1: Faker::Address.street_address,
        address_2: Faker::Address.street_name,
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country,
    })
    random_user.picture.attach(io: pictures[i+1], filename: user.name)
end

5.times do |i|
    property = Property.create!({
        name: Faker::Lorem.unique.sentence(word_count: 3),
        description: description,
        headline: Faker::Lorem.unique.sentence(word_count: 3),
        address_1: Faker::Address.street_address,
        address_2: Faker::Address.street_name,
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country,
        price: Money.from_amount((50..100).to_a.sample, 'USD'),
        bedroom_count: (1..5).to_a.sample,
        bed_count: (1..10).to_a.sample,
        guest_count: (1..20).to_a.sample,
        bathroom_count: (1..4).to_a.sample
    })
    property.images.attach(io: File.open("db/images/p_#{i + 1}.jpg"), filename: property.name)
    property.images.attach(io: File.open("db/images/p_5.jpg"), filename: property.name)
    property.images.attach(io: File.open("db/images/p_6.jpg"), filename: property.name)
    property.images.attach(io: File.open("db/images/p_7.jpg"), filename: property.name)
    property.images.attach(io: File.open("db/images/p_8.jpg"), filename: property.name)
    property.images.attach(io: File.open("db/images/p_9.jpg"), filename: property.name)
    property.images.attach(io: File.open("db/images/p_10.jpg"), filename: property.name)


    ((1..(ameneties_data.length() - 1)).to_a.sample).times do
        property.ameneties << Amenity.all.sample
    end 

    ((5..10).to_a.sample).times do
        Review.create!({
            content: Faker::Lorem.paragraph(sentence_count: 10),
            cleanliness_rating: (1..5).to_a.sample,
            checkin_rating: (1..5).to_a.sample,
            accuracy_rating: (1..5).to_a.sample,
            communication_rating: (1..5).to_a.sample,
            location_rating: (1..5).to_a.sample,
            value_rating: (1..5).to_a.sample,
            property: property,
            user: User.all.sample
        })
    end
end

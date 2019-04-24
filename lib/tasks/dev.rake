namespace :dev do
  desc "Dev environment configuration"
  task setup: :environment do
    %x(rails db:drop db:create db:migrate)

    kinds = %w(Friend Comercial Known)

    kinds.each do |k|
      Kind.create!(description: k)
    end

    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(65.years.ago, 18.years.ago),
        kind: Kind.all.sample
      )
    end

    Contact.all.each do |c|
      Random.rand(5).times do |t|
        c.phones.create!(number:Faker::PhoneNumber.cell_phone)
      end
    end

    Contact.all.each do |c|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: c
      )
    end
  end

end

task :create_charities => :environment do

	Charity.create(name: "Animals Australia")
	Charity.create(name: "Pencils of Promise")
	Charity.create(name: "Peter MacCallum Cancer Centre")
end
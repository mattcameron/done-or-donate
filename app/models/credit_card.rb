class CreditCard

	def initialize(card_number, expiry_month, expiry_year, cvc, name)
		@number = card_number
		@expiry_month = expiry_month
		@expiry_year = expiry_year
		@cvc = cvc
		@name = name
	end

end
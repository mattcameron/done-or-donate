if Rails.env.development?

	PinPayment.public_key = 'pk_-P1VHDRbe8uGI111QnxX1A'
	PinPayment.secret_key = 'RJNZX0VQ1w5j9IK5KFZX9w'
	PinPayment.api_url    = 'https://test-api.pin.net.au' # Test endpoint
end


### add production credentials when appropriate
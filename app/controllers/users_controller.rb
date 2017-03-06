require "json"
require "open-uri"

class UsersController < ApplicationController
  def data
    require "open-uri"
    require 'json'
# Get data from url
    url = "https://randomapi.com/api/6de6abfedb24f889e0b5f675edc50deb?fmt=raw&sole"
		response = URI.parse(url).read
		@data = JSON.parse(response)

# Parse data
		@data.each do |user|
			if User.count >= 100
				@message = "Cannot save user when database had 100 records"
			else
				new_user = User.new
				new_user.first = user['first']
				new_user.last = user['last']
				new_user.email = user['email']
				new_user.address = user['address']
				new_user.balance = user['balance']
				new_user.save
			end
		end
  end

  def index
  	@users = User.paginate(:page => params[:page], :per_page => 10)
  end
end

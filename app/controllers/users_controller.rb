require "json"
require "open-uri"

class UsersController < ApplicationController
  def data
  end

  def index
    require "open-uri"
    require 'json'
    # Get data from url
    url = "https://randomapi.com/api/6de6abfedb24f889e0b5f675edc50deb?fmt=raw&sole"
    response = URI.parse(url).read
    data = JSON.parse(response)

    # Parse data
    if User.count >= 100
      @message = "Cannot save user when database had 100 records"
    else
      data.each do |user|
        new_user = User.create(first:user['first'],
                              last:user['last'],
                              email:user['email'],
                              address:user['address'],
                              balance:user['balance'])
        new_user.save
      end
    end
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end
end

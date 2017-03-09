require "json"
require "open-uri"

class UsersController < ApplicationController
  def data
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
    redirect_to users_path
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :first, :last, :address, :balance)
    end

end

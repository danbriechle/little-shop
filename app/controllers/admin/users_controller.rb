class Admin::UsersController < ApplicationController

  def index
    @users = User.default_users
  end

end

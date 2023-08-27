class UsersController < ApplicationController
  def show
    @name = current_user.name
    @opinions = current_user.opinions
  end
end

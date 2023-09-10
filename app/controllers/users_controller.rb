class UsersController < ApplicationController

  def create
    @favorite = Favorite.new(favorite_params)
  end

  def show
    @user = User.find(params[:id])
    @favorite = Favorite.new
    @opinions = @user.opinions.order('created_at DESC')
    @show_opinions =  @opinions.where(privacy_id: 2).order('created_at DESC')
    @my_favorite = @user.favorite
    
    if @my_favorite.present?
      @my_favorite.update_current_price
      @registered_date = @my_favorite.created_at
      @registered_price = @my_favorite.registered_price
      @current_price = @my_favorite.price
      @profit_loss = @my_favorite.calculate_profit_loss
    end

  end

  private

  def favorite_params
    params.require(:favorite).permit(:symbol, :price).merge(user_id: current_user.id)
  end

end

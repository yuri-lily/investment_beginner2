class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @favorite = @user.build_favorite(favorite_params)
    @favorite.registered_price = fetch_current_price(@favorite.symbol)

    if @favorite.save
      redirect_to user_path(@user), notice: 'Favorite was successfully created.'
    else
      # 保存に失敗した場合の処理（たとえば、エラーメッセージを表示するなど）
      redirect_to user_path(@user), alert: 'There was an error saving your favorite.'
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:symbol).merge(user_id: current_user.id)
  end

  def fetch_current_price(symbol)
    api_key = ENV["ALPHA_VANTAGE_API_KEY"]
    url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=#{api_key}"

    response = HTTParty.get(url)
    data = JSON.parse(response.body)
    
    # ALPHA_VANTAGEの応答から正確な株価の情報を抽出する必要があります。
    data["Global Quote"]["05. price"].to_f
  rescue StandardError => e
    Rails.logger.error("Error fetching data for symbol #{symbol}: #{e.message}")
    nil
  end
end








=begin

  def create
    @favorite = Favorite.new(favorite_params)
    
    symbol = @favorite.symbol
    api_key = ENV["ALPHA_VANTAGE_API_KEY"] # 実際のプロジェクトでは外部設定から読み込むことをお勧めします
    interval = '1min'
    url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=#{symbol}&interval=#{interval}&apikey=#{api_key}"

    response = HTTParty.get(url)
    data = JSON.parse(response.body)

    if data['Time Series (1min)']
      latest_data = data['Time Series (1min)'].first[1]
      latest_close_price = latest_data['4. close']

      @favorite.registered_price = latest_close_price

      if @favorite.save
        redirect_to user_path(current_user)
      else
        render 'users/show'
      end
    end
  end

  

  # ... 他のアクション ...

  private

  def favorite_params
    params.require(:favorite).permit(:symbol).merge(user_id: current_user.id)
  end
end

=end
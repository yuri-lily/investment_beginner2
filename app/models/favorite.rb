class Favorite < ApplicationRecord
  belongs_to :user
  validates :symbol, :registered_price, presence: true

  def update_current_price
    api_key = ENV["ALPHA_VANTAGE_API_KEY"]
    url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=#{api_key}"

    response = HTTParty.get(url)
    data = JSON.parse(response.body)

    latest_price = data["Global Quote"]["05. price"].to_f
    self.update(price: latest_price)
  rescue StandardError => e
    Rails.logger.error("Error fetching data for symbol #{symbol}: #{e.message}")
  end

  # 損益を計算するメソッド
  def calculate_profit_loss
    # registered_price（登録時の価格）とprice（現在の価格）の差を返す
    if price && registered_price
      (price - registered_price).round(2)
    else
      nil
    end
  end

end
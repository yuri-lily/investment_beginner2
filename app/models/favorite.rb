class Favorite < ApplicationRecord
  belongs_to :user
  with_options presence: true do
    validates :symbol, format: { with: /\A[a-zA-Z]{1,4}\z/, message: "is invalid.Please enter an alphabet of four letters or less"}
  end

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

  def calculate_profit_loss
    if price && registered_price
      (price - registered_price).round(2)
    else
      nil
    end
  end

end
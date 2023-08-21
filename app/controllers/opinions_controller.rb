class OpinionsController < ApplicationController
  def index
    @stock_data = get_stock_data(['AAPL', 'MSFT', 'AMZN'])
  end

  def new
  end

  private

  def get_stock_data(symbols)
    require 'httparty'
    
    api_key = 'TJORXS3OP3GMKUCY'
    interval = '1min'
    
    stock_data = {}
    
    symbols.each do |symbol|
      url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=#{symbol}&interval=#{interval}&apikey=#{api_key}"
      response = HTTParty.get(url)
      data = JSON.parse(response.body)
      
      if data['Time Series (1min)']
        latest_data = data['Time Series (1min)'].first
        stock_data[symbol] = {
          latest_close_price: latest_data[1]['4. close'],
          latest_date: latest_data[0]
        }
      else
        stock_data[symbol] = {
          latest_date: 'Data not available',
          latest_close_price: 'Data not available'
        }
      end
    end
    
    stock_data
  end

end

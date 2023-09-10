class OpinionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :new, :create, :show, :search_stock_data]

  def index
    @opinions = Opinion.where(privacy_id: 2).includes(:user).order('created_at DESC')

    @aapl_data = get_stock_data('AAPL')
    @msft_data = get_stock_data('MSFT')
    @amzn_data = get_stock_data('AMZN')
  end

  def new
    @opinion = Opinion.new
    @opinions = Opinion.where(brand: @symbol, privacy_id: 2).includes(:user).order('created_at DESC')
  end

  def create
    @opinion = Opinion.new(opinion_params)
    if @opinion.save
      redirect_to user_path(current_user)
    else
      @opinions = Opinion.where(brand: @symbol, privacy_id: 2).includes(:user).order('created_at DESC')
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @opinion.comments.includes(:user).order('created_at DESC')
  end

  def edit
  end

  def update
    if @opinion.update(opinion_params)
      redirect_to user_path(@opinion.user) 
    else
      render :edit
    end
  end

  def destroy
    if current_user == @opinion.user
      @opinion.comments.destroy_all
      @opinion.destroy
    else
      render  :index
    end
    redirect_to user_path(current_user)
  end

  def search_stock_data
    require 'httparty'
    symbol = params[:symbol]
    api_key = ENV["ALPHA_VANTAGE_API_KEY"]
    url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&apikey=#{api_key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    @symbol = params[:symbol]

    if data["Time Series (Daily)"]
      time_series = data["Time Series (Daily)"]
      latest_date = time_series.keys.first
      @stock_data = {
        latest_date: latest_date,
        latest_close_price: time_series[latest_date]["4. close"]
      }
      @symbol = symbol
      @opinions = Opinion.where(brand: @symbol, privacy_id: 2).includes(:user).order('created_at DESC')
    else
      @stock_data = nil
      @symbol = nil
      @opinions = []
    end
    @opinion = Opinion.new
    render :new
  end

  private

  def get_stock_data(symbol)
    api_key = ENV["ALPHA_VANTAGE_API_KEY"]
    interval = '1min'
  
    url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=#{symbol}&interval=#{interval}&apikey=#{api_key}"
    response = HTTParty.get(url)
    data = JSON.parse(response.body)
  
    if data['Time Series (1min)']
      latest_data = data['Time Series (1min)'].first[1]
      latest_close_price = latest_data['4. close']
      latest_date = data['Time Series (1min)'].first[0]
  
      return {
        latest_close_price: latest_close_price,
        latest_date: Time.parse(latest_date).utc
      }
    else
      return {
        latest_close_price: 'Data not available',
        latest_date: 'Data not available'
      }
    end
  end

  def opinion_params
    params.require(:opinion).permit(:brand, :privacy_id, :theory).merge(user_id: current_user.id)
  end

  def set_params
    @opinion = Opinion.find(params[:id])
  end

  def move_to_index
    return if current_user == @opinion.user

    redirect_to root_path
  end

end

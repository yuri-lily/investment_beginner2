class OpinionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :new, :create, :show]

  def index
    @opinions = Opinion.where(privacy_id: 2).includes(:user)
    @stock_data = get_stock_data(['AAPL', 'MSFT', 'AMZN'])
  end

  def new
    @opinion = Opinion.new
  end

  def create
    @opinion = Opinion.new(opinion_params)
    if @opinion.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @opinion.comments.includes(:user)
  end

  def edit
  end

  def update
    if @opinion.update(opinion.params)
      redirect_to user_path()
    else
      render :edit
    end
  end

  def destroy
    if current_user == @opinion.user
      @opinion.destroy
    else
      render  :index
    end
    redirect_to user_path(current_user)
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

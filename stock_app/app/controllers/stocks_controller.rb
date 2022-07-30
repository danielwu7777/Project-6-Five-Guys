#Edited 7/26/2022 by Jake McCann
#Edited 7/27/2022
class StocksController < ApplicationController
  Year_Unix = 31556926
  Month_unix = 2629743
  before_action :set_stock, only: %i[ show edit update destroy ]

  # GET /stocks or /stocks.json
  # Edited 7/26/22 by Noah Moon
  def index
    @news_articles = StocksHelper.GeneralNews
    @stocks = Stock.all
    if current_user.currentbalance.nil? && current_user.initialbalance.nil?
      current_user.update currentbalance: current_user.liquidcash, initialbalance: current_user.liquidcash
      current_user.save
    end
  end

  # GET /stocks/1 or /stocks/1.json
  def show
    @stock = Stock.find(params[:id])
    data = JSON.parse(FinnhubClient.stock_candles(@stock.ticker, 'D', Time.now.utc.to_i - Year_Unix, Time.now.utc.to_i).to_json)
    puts "FIND THIS:  " + data.class.to_s
    @chart_data = {}
    @y_min = nil
    data["t"].each_with_index{|ele,i|
      @chart_data[Time.at(ele).to_date] =  [data["o"][i],data["c"][i],data["l"][i],data["h"][i]]
      @y_min = data["l"][i] if  @y_min.nil? || data["l"][i] < @y_min
    }
    @y_min - 10 > 0 ? @y_min = (@y_min - 10).round : @y_min = 0
    @date = Date.today.to_s
    @news_articles = StocksHelper.SpecificNews(@stock.ticker)
  end

  #created 7/21/22 by Noah Moon
  def trade
    @stock = Stock.find(params[:id])
    @transactions = current_user.transactions
    @transactions = @transactions.filter{|transaction|transaction.shares > 0 && transaction.ticker == @stock.ticker}
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to stock_url(@stock), notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to stock_url(@stock), notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Created 7/24/2022 by Jake McCann
  #
  # Updates model and view on price change
  # ticker: stock symbol
  # new_price: price after update
  def self.price_change ticker, new_price
    # Update stock
    StocksHelper.GeneralNews
    stock_record = Stock.find_by ticker: ticker
    old_price = stock_record.price
    stock_record.update_price new_price

    # Update owned_stock
    OwnedStocksController.update_price ticker, old_price, new_price
  end

  # Created 7/26/22 by Jake McCann
  # updates @stocks to new values in db for polling
  def price_change_polling
    @stocks = Stock.all
    render @stocks, :template => '_stock'
  end

  def specific_poll
    @stock = Stock.find(params[:id])
    render :partial => 'stock_show', :data => @stock
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:ticker, :price)
    end
end

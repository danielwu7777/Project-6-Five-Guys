class OwnedStocksController < ApplicationController
  before_action :set_owned_stock, only: %i[ show edit update destroy ]

  # GET /owned_stocks or /owned_stocks.json
  # Edited 7/22/22 by Noah Moon
  def index
    @owned_stocks = current_user.owned_stocks.filter{|stock| stock.shares_owned > 0}
  end

  # GET /owned_stocks/1 or /owned_stocks/1.json
  def show
  end

  # Created 7/21/22 by Noah Moon
  # Edited 7/22/22 by Noah Moon
  # Edited 7/25/22 by Noah Moon
  def buy
    @owned_stock = OwnedStock.find_by stock_id: params[:id], user_id: current_user.id
    unless @owned_stock
      # creates new owned stock
      @owned_stock = OwnedStock.new stock_id: params[:id], user_id: current_user.id, ticker: Stock.find(params[:id]).ticker,
                                    shares_owned: 0, current_value: 0, total_cost: 0
      @owned_stock.save
    end
    @transaction = Transaction.new ticker: @owned_stock.ticker, action: "buy", shares: 0, user_id: current_user.id, stock_id: params[:id]
    @transaction.save
  end

  # Created 7/21/22 by Noah Moon
  # Edited 7/22/22 by Noah Moon
  def sell
    @owned_stock = OwnedStock.find_by stock_id: params[:id], user_id: current_user.id
    if @owned_stock && @owned_stock.shares_owned > 0
      @transaction = Transaction.new ticker: @owned_stock.ticker, action: "sell", shares: 0, user_id: current_user.id, stock_id: params[:id]
      @transaction.save
    else
      @stock = Stock.find params[:id]
      respond_to{|format| format.html{redirect_to @stock, alert: "Error: Must own stock to sell"}}
    end

  end

  # Created 7/21/22 by Noah Moon
  # Edited 7/22/22 by Noah Moon
  # Edited 7/23/22 by Noah Moon
  # Edited 7/25/22 by Noah Moon
  def buy_stock
    @owned_stock = OwnedStock.find_by ticker: params[:transaction][:ticker], user_id: current_user.id
    @transaction = Transaction.find params[:transaction][:id]

    # throws error if trying to purchase 0 or less
    if params[:transaction][:shares].to_i <= 0
      respond_to{|format| format.html{redirect_to :buy, alert: "Invalid Entry: Cannot purchase less than 1 share"}}
      return
    end

    # updates database according to form
    current_user.liquidcash = current_user.liquidcash - params[:transaction][:shares].to_f * @owned_stock.stock.price.to_f
      if current_user.valid?
        @owned_stock.update shares_owned: params[:transaction][:shares].to_i + @owned_stock.shares_owned.to_i,
                            current_value: (params[:transaction][:shares].to_i + @owned_stock.shares_owned.to_i) * @owned_stock.stock.price,
                            total_cost: @owned_stock.total_cost + params[:transaction][:shares].to_i * @owned_stock.stock.price
        @transaction.update shares: params[:transaction][:shares], time: DateTime.now
        @transaction.save
        current_user.save
        @owned_stock.save
        respond_to{|format| format.html { redirect_to owned_stock_url(@owned_stock), notice: "Purchase Successfully Completed" } }
      else
        # Throws error if not enough liquid cash to complete order
        respond_to{|format| format.html { redirect_to :buy, alert: current_user.errors.messages.first[1][0]}}
      end
  end

  # Created 7/21/22 by Noah Moon
  # Edited 7/22/22 by Noah Moon
  # Edited 7/23/22 by Noah Moon
  # Edited 7/25/22 by Noah Moon
  def sell_stock
    @owned_stock = OwnedStock.find_by ticker: params[:transaction][:ticker], user_id: current_user.id
    @transaction = Transaction.find params[:transaction][:id]
    if params[:transaction][:shares].to_i <= 0
      respond_to{|format| format.html{redirect_to :sell, alert: "Invalid Entry: Cannot sell less than 1 share"}}
      return
    end
      @owned_stock.shares_owned = @owned_stock.shares_owned.to_i - params[:transaction][:shares].to_i
      # saves to database if sold stocks <= owned stocks, throws error otherwise
      if @owned_stock.valid?
        @owned_stock.update current_value: @owned_stock.shares_owned * @owned_stock.stock.price,
                            total_cost: @owned_stock.total_cost.to_f - params[:transaction][:shares].to_f * @owned_stock.stock.price
        @transaction.update shares: params[:transaction][:shares], time: DateTime.now
        @transaction.save
        current_user.liquidcash = current_user.liquidcash + params[:transaction][:shares].to_f * @owned_stock.stock.price.to_f
        current_user.save
        @owned_stock.save
        respond_to{|format| format.html { redirect_to owned_stock_url(@owned_stock), notice: "Sale Successfully Completed" }
        format.json { render :show, status: :created, location: @owned_stock }}
      else
        respond_to{|format| format.html{redirect_to :sell, alert: @owned_stock.errors.messages.first[1][0]}}
        @owned_stock.shares_owned = @owned_stock.shares_owned.to_i + params[:transaction][:shares].to_i
      end
  end


  # GET /owned_stocks/new
  def new
    @owned_stock = OwnedStock.new
  end

  # GET /owned_stocks/1/edit
  def edit
  end

  # POST /owned_stocks or /owned_stocks.json
  def create
    @owned_stock = OwnedStock.new(owned_stock_params)

    respond_to do |format|
      if @owned_stock.save
        format.html { redirect_to (@owned_stock), notice: "Owned stock was successfully created." }
        format.json { render :show, status: :created, location: @owned_stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @owned_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owned_stocks/1 or /owned_stocks/1.json
  def update
    form_params = owned_stock_params
    stock_params = {:shares_owned => @owned_stock.shares_owned.to_i + form_params[:shares_owned].to_i, :ticker => @owned_stock.ticker}
    respond_to do |format|
      if @owned_stock.update(owned_stock_params)
        format.html { redirect_to owned_stock_url(@owned_stock), notice: "Owned stock was successfully updated." }
        format.json { render :show, status: :ok, location: @owned_stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @owned_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owned_stocks/1 or /owned_stocks/1.json
  def destroy
    @owned_stock.destroy

    respond_to do |format|
      format.html { redirect_to owned_stocks_url, notice: "Owned stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Created 7/25/2022 by Jake McCann
  #
  # Updates model and view on price change
  # ticker: stock symbol
  # new_price: price after update
  def self.update_price ticker, old_price, new_price
    impacted_users = []
    OwnedStock.where(:ticker => ticker).each {|owned_stock| impacted_users.push owned_stock.update_price(new_price) }
    UsersController.update_portfolio_value impacted_users, old_price, new_price
  end

  # Created 7/26/22 by Jake McCann
  # updates @owned_stocks to new values in db for polling
  def price_change_polling
    @owned_stocks = OwnedStock.where(:user_id => current_user.id)
    render :partial => 'owned_stock', :collection => @owned_stocks
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owned_stock
      @owned_stock = OwnedStock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def owned_stock_params
      params.require(:owned_stock).permit(:user_id, :ticker, :shares_owned, :total_cost)
    end
end

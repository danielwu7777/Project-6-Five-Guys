class OwnedStocksController < ApplicationController
  before_action :set_owned_stock, only: %i[ show edit update destroy ]

  # GET /owned_stocks or /owned_stocks.json
  # Edited 7/22/22 by Noah Moon
  def index
    @owned_stocks = current_user.owned_stocks
  end
  #created 7/21/22 by Noah Moon
  def show_stock
    render "stocks/show"
  end

  # GET /owned_stocks/1 or /owned_stocks/1.json
  def show
  end

  # Created 7/21/22 by Noah Moon
  # Edited 7/22/22 by Noah Moon
  def buy
    if OwnedStock.exists?(stock_id: params[:id], user_id: current_user.id)
      @owned_stock = OwnedStock.find_by stock_id: params[:id], user_id: current_user.id
    else
      @owned_stock = OwnedStock.new stock_id: params[:id]
      @owned_stock.user_id = current_user.id
      @owned_stock.ticker = @owned_stock.stock.ticker
      @owned_stock.shares_owned = 0
      @owned_stock.save
    end
    @transaction = Transaction.new ticker: @owned_stock.ticker, action: "buy", shares: 0, user_id: current_user.id, stock_id: params[:id]
    @transaction.save
  end

  # Created 7/21/22 by Noah Moon
  # Edited 7/22/22 by Noah Moon
  def sell
    @owned_stock = OwnedStock.find_by stock_id: params[:id], user_id: current_user.id
    @transaction = Transaction.new ticker: @owned_stock.ticker, action: "sell", shares: 0, user_id: current_user.id, stock_id: params[:id]
    @transaction.save
  end

  # Created 7/21/22 by Noah Moon
  # Edited 7/22/22 by Noah Moon
  # Edited 7/23/22 by Noah Moon
  def buy_stock

    @owned_stock = OwnedStock.find_by ticker: params[:transaction][:ticker], user_id: current_user.id
    @transaction = Transaction.find params[:transaction][:id]

    # throws error if trying to purchase 0 or less
    if params[:transaction][:shares].to_i <= 0
      @buy_error = "Invalid: cannot sell less than 1 stock"
      respond_to do |format|
        format.html { render :buy}
        format.json { render json: @owned_stock.errors, status: :unprocessable_entity }
      end
      return
    end

    # updates database according to form
    if @owned_stock

      current_user.liquidcash = current_user.liquidcash - params[:transaction][:shares].to_f * @owned_stock.stock.price.to_f

    end

    respond_to do |format|
    if current_user.valid?
      @owned_stock.shares_owned = params[:transaction][:shares].to_i + @owned_stock.shares_owned.to_i
      @owned_stock.total_cost = @owned_stock.shares_owned * @owned_stock.stock.price
      @transaction.shares = params[:transaction][:shares]
      @transaction.time = DateTime.now
      @transaction.save
      current_user.save
      @owned_stock.save

        format.html { redirect_to owned_stock_url(@owned_stock), notice: "Owned stock was successfully Updated." }
        format.json { render :show, status: :created, location: @owned_stock }

    else
      #current_user.liquidcash = current_user.liquidcash + params[:transaction][:shares].to_f * @owned_stock.stock.price.to_f
      format.html { render :buy }
      format.json { render json: @owned_stock.errors, status: :unprocessable_entity }
      @buy_error = current_user.errors.messages.first[1]
    end
    end



  end

  # Created 7/21/22 by Noah Moon
  # Edited 7/22/22 by Noah Moon
  # Edited 7/23/22 by Noah Moon
  def sell_stock

    @owned_stock = OwnedStock.find_by ticker: params[:transaction][:ticker], user_id: current_user.id
    @transaction = Transaction.find params[:transaction][:id]

    if params[:transaction][:shares].to_i <= 0
      @sell_error = "Invalid: cannot sell less than 1 stock"
      respond_to do |format|
        format.html { render :sell}
        format.json { render json: @owned_stock.errors, status: :unprocessable_entity }
      end
      return
    end

    if @owned_stock
      @owned_stock.shares_owned = @owned_stock.shares_owned.to_i - params[:transaction][:shares].to_i
    end
    respond_to do |format|
      # saves to database if sold stocks <= owned stocks, throws error otherwise
      if @owned_stock.valid?
        @owned_stock.total_cost = @owned_stock.shares_owned * @owned_stock.stock.price
        @transaction.shares = params[:transaction][:shares]
        @transaction.time = DateTime.now
        @transaction.save
        current_user.liquidcash = current_user.liquidcash + params[:transaction][:shares].to_f * @owned_stock.stock.price.to_f
        current_user.save
        @owned_stock.save

          format.html { redirect_to owned_stock_url(@owned_stock), notice: "Owned stock was successfully Updated." }
          format.json { render :show, status: :created, location: @owned_stock }

      else
        format.html { render :sell, status: :unprocessable_entity }
        format.json { render json: @owned_stock.errors, status: :unprocessable_entity }
        @owned_stock.shares_owned = @owned_stock.shares_owned.to_i + params[:transaction][:shares].to_i
        @sell_error = @owned_stock.errors.messages.first[1]
      end
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

class OwnedStocksController < ApplicationController
  before_action :set_owned_stock, only: %i[ show edit update destroy ]

  # GET /owned_stocks or /owned_stocks.json
  def index
    @owned_stocks = OwnedStock.all
  end
  def show_stock
    render "stocks/show"
  end

  # GET /owned_stocks/1 or /owned_stocks/1.json
  def show
  end

  def buy
    @owned_stock = OwnedStock.find(params[:id])
  end
  def buy_stock

    @owned_stock = OwnedStock.find_by id: 1
    if @owned_stock
      @owned_stock.shares_owned = params[:owned_stock][:purchased].to_i + @owned_stock.shares_owned.to_i
      @owned_stock.total_cost = @owned_stock.shares_owned * @owned_stock.stock.price
      @owned_stock.save
    end

    respond_to do |format|
        format.html { redirect_to owned_stock_url(@owned_stock), notice: "Owned stock was successfully Updated." }
        format.json { render :show, status: :created, location: @owned_stock }
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

require "test_helper"

class OwnedStocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owned_stock = owned_stocks(:one)
  end

  test "should get index" do
    get owned_stocks_url
    assert_response :success
  end

  test "should get new" do
    get new_owned_stock_url
    assert_response :success
  end

  test "should create owned_stock" do
    assert_difference('OwnedStock.count') do
      post owned_stocks_url, params: { owned_stock: { shares_owned: @owned_stock.shares_owned, ticker: @owned_stock.ticker, total_cost: @owned_stock.total_cost, user_id: @owned_stock.user_id } }
    end

    assert_redirected_to owned_stock_url(OwnedStock.last)
  end

  test "should show owned_stock" do
    get owned_stock_url(@owned_stock)
    assert_response :success
  end

  test "should get edit" do
    get edit_owned_stock_url(@owned_stock)
    assert_response :success
  end

  test "should update owned_stock" do
    patch owned_stock_url(@owned_stock), params: { owned_stock: { shares_owned: @owned_stock.shares_owned, ticker: @owned_stock.ticker, total_cost: @owned_stock.total_cost, user_id: @owned_stock.user_id } }
    assert_redirected_to owned_stock_url(@owned_stock)
  end

  test "should destroy owned_stock" do
    assert_difference('OwnedStock.count', -1) do
      delete owned_stock_url(@owned_stock)
    end

    assert_redirected_to owned_stocks_url
  end
end

require "application_system_test_case"

class OwnedStocksTest < ApplicationSystemTestCase
  setup do
    @owned_stock = owned_stocks(:one)
  end

  test "visiting the index" do
    visit owned_stocks_url
    assert_selector "h1", text: "Owned Stocks"
  end

  test "creating a Owned stock" do
    visit owned_stocks_url
    click_on "New Owned Stock"

    fill_in "Shares owned", with: @owned_stock.shares_owned
    fill_in "Ticker", with: @owned_stock.ticker
    fill_in "Total cost", with: @owned_stock.total_cost
    fill_in "User", with: @owned_stock.user_id
    click_on "Create Owned stock"

    assert_text "Owned stock was successfully created"
    click_on "Back"
  end

  test "updating a Owned stock" do
    visit owned_stocks_url
    click_on "Edit", match: :first

    fill_in "Shares owned", with: @owned_stock.shares_owned
    fill_in "Ticker", with: @owned_stock.ticker
    fill_in "Total cost", with: @owned_stock.total_cost
    fill_in "User", with: @owned_stock.user_id
    click_on "Update Owned stock"

    assert_text "Owned stock was successfully updated"
    click_on "Back"
  end

  test "destroying a Owned stock" do
    visit owned_stocks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Owned stock was successfully destroyed"
  end
end
